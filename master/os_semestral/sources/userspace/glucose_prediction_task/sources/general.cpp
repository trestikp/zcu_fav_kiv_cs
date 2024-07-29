#include <general.h>

#include <std_lib.h>
#include <constants.h>


General::General()
{

}

uint32_t General::setup_uart()
{
    uart_file = open("DEV:uart/0", NFile_Open_Mode::Read_Write);

	TUART_IOCtl_Params params;
	params.baud_rate = NUART_Baud_Rate::BR_115200;
	params.char_length = NUART_Char_Length::Char_8;
	ioctl(uart_file, NIOCtl_Operation::Set_Params, &params);

	params.rx_interrupt = true;
	ioctl(uart_file, NIOCtl_Operation::Enable_Event_Detection, &params);

	return uart_file;
}

void General::print_welcome_banner()
{
	print_line(STR_WELCOME_LINE_1);
	print_line(STR_WELCOME_LINE_2);
	print_line(STR_WELCOME_LINE_3);
	print_line(STR_WELCOME_LINE_4);
	print_line(STR_WELCOME_LINE_6);
	print_line(STR_WELCOME_LINE_7);
	print_line(STR_WELCOME_LINE_8);
}

void General::print_val_command_request()
{
	print_line(STR_REQ_VAL_OR_CMD);
}

void General::print_line(const char* str)
{
	if (str)
		std::fputs(uart_file, str);
	std::fputs(uart_file, STR_CRLF);
}

void General::print_line_and_prompt_input(const char* str)
{
	print_line(str);
	prompt_user_input();
}

void General::prompt_user_input()
{
	std::fputs(uart_file, STR_USER_INPUT);
}

Res_Code General::get_res_no()
{
	return err_no;
}

App_State General::get_app_state()
{
	return state;
}

void General::reset_state()
{
	state = App_State::WAITING_FOR_INPUT;
	gen_counter = 0;
	bzero(out_buf, LARGE_BUFF);
}

void General::init_defaults()
{
	// most of those should already be set
	delta_counter = 0;
	state = App_State::WAITING_FOR_INPUT;
	gen_counter = 0;
	bzero(out_buf, LARGE_BUFF);
}

uint32_t General::read_cb_line_to_buf()
{
	uint32_t read_bytes = 0;
	bzero(uart_buf, DEF_BUFFER_SIZE);
	
	if ((read_bytes = cb.read_until(uart_buf, DEF_BUFFER_SIZE, '\r')) <= 0)
		read_bytes = cb.read_until(uart_buf, DEF_BUFFER_SIZE, '\n');
	
	return read_bytes;
}

void General::trim_eol(char* buf)
{
	uint32_t len = strlen(buf) - 1;

	while (buf[len] == '\n' || buf[len] == '\r')
	{
		buf[len] = '\0';
		len--;
	}
}

bool General::buf_contains_char(char target)
{
	for (int i = 0; i < DEF_BUFFER_SIZE; i++)
		if (uart_buf[i] == target) return true;

	return false;
}

void General::reset_err_no()
{
	err_no = Res_Code::NO_ERR;
}

void General::set_err_no(Res_Code e)
{
	err_no = e;
}

uint32_t General::read_line()
{
	// Circular_Buffer<char> cb; // made into an attribute
	bool contains_newline = false;
	
	do {
		bzero(uart_buf, DEF_BUFFER_SIZE);
		if (std::fgets(uart_file, uart_buf, DEF_BUFFER_SIZE) == nullptr) 
			continue;

		if (buf_contains_char('\r') || buf_contains_char('\n')) // QEMU USES ONLY \r FOR END OF LINE
			contains_newline = true;
		
		// always write to "cb", so it contains end of file
		cb.write(uart_buf, strlen(uart_buf));
	} while (!contains_newline);	

	print_line(nullptr); // prints EOL
	return read_cb_line_to_buf();
}

uint32_t General::read_line_non_blocking()
{
	bool contains_newline = false;

	bzero(uart_buf, DEF_BUFFER_SIZE);
	if (std::fgets_nb(uart_file, uart_buf, DEF_BUFFER_SIZE) <= 0)
		return 1; // nothing read

	// check if new input contains end of line
	if (buf_contains_char('\r') || buf_contains_char('\n')) // QEMU USES ONLY \r FOR END OF LINE
		contains_newline = true;

	cb.write(uart_buf, strlen(uart_buf));

	if (contains_newline)
	{
		read_cb_line_to_buf(); // parsing requires reading before its called
		print_line(nullptr); // prints EOL
		return 0;
	}

	return 2;
}

int General::read_int()
{
	reset_err_no();

	if (read_line() <= 0) {
		set_err_no(Res_Code::INPUT_ERR);
		return 0;
	}

	// trim end of line char
	for (int i = 0; i < DEF_BUFFER_SIZE; i++) {
		if (uart_buf[i] == '\r' || uart_buf[i] == '\n') {
			uart_buf[i] = 0;
			break;
		}
	}

	int result = 0;
	if ((result = atoi(uart_buf)) <= 0)
		set_err_no(Res_Code::PARSE_ERR);
	
	return result;
}

uint32_t General::read_int_into(uint32_t &target)
{
	while ((target = read_int()) <= 0)
	{
		if (target <= 0)
			switch (get_res_no())
			{
				case Res_Code::INPUT_ERR:
					print_line(STR_INT_IN_ERR);
					break;
				case Res_Code::PARSE_ERR:
					print_line(STR_INT_PARSE_ERR);
					break;
				default:
					print_line(STR_INT_DEF_ERR);
					break;
			}
		
		prompt_user_input();
	}

	return 0;
}

uint32_t General::read_t_delta() {
	print_line_and_prompt_input(STR_REQ_T_DELTA);
	read_int_into(t_delta);

	return 0;
}

uint32_t General::read_t_pred()
{
	print_line_and_prompt_input(STR_REQ_T_PRED);
	read_int_into(t_pred);

	return 0;
}

Input General::parse_val_or_command()
{
	// read must be done by caller

	// trim end of line char(s)
	trim_eol(uart_buf);

	if (!strncmp(uart_buf, STR_STOP, DEF_BUFFER_SIZE))
		return Input::STOP_CMD;
	else if (!strncmp(uart_buf, STR_PARAMETERS, DEF_BUFFER_SIZE))
		return Input::PARAM_CMD;
	else 
	{
		bool is_float = false;
		measured_value = atof(uart_buf, is_float);

		if (is_float)
			return Input::FLOAT_IN;
	}
	
	return Input::ERR;
}

void General::print_app_crash()
{
	print_line(STR_APP_CRASH_ERR);
	close(uart_file);
}

Input General::read_val_or_command()
{
	// prompt_user_input();
	if (read_line_non_blocking())
		return Input::NO_INPUT;

	return parse_val_or_command();
}

Input General::read_val_or_command_blocking()
{
	if (read_line() <= 0)
		return Input::ERR;

	return parse_val_or_command();
}

/**********************************************************************************************************************/
/*    generic algorithm controls                                                                              		  */
/**********************************************************************************************************************/

bool General::malloc_success(void* ptr)
{
	// while debugging i ran across failed malloc returning 0x1
	return ptr != nullptr && ptr != (void*) 0x1;
}

float General::pm_avg()
{
	float meas_avg = 0.0;
	for (int i = 0; i < t_steps; i++) 
		meas_avg += past_measurements[i];
	meas_avg = meas_avg / t_steps;

	return meas_avg;
}

Res_Code General::setup_gea()
{
	Chromosome_NS::t_delta = t_delta;
	t_steps = t_pred / t_delta;

	// alloc needed memory
	past_measurements = (float*) std::malloc(sizeof(float) * t_steps);
	predicted_values = (float*) std::malloc(sizeof(float) * t_steps);
	old_gen = (Generation*) std::malloc(sizeof(Generation));
	gen = (Generation*) std::malloc(sizeof(Generation));
	next_gen = (Generation*) std::malloc(sizeof(Generation));

	// check if all memory was alloced successfully - crash application on fail
	if (!(malloc_success(past_measurements) && malloc_success(predicted_values) && malloc_success(old_gen) &&
		malloc_success(gen) && malloc_success(next_gen)))
		return Res_Code::MEM_FAIL;

	// --- random init of generations - we only need gen initialized (old_gen and next_gen get init from gen later);
	old_gen->init_random(); // fix: old_gen must be init when stop is called on first calculation
	gen->init_random();

	return Res_Code::NO_ERR;
}

void General::do_stop_command()
{
	// --- error checking
	if ((old_gen == nullptr) || (delta_counter < t_steps))
	{
		print_line(STR_STOP_NO_RES_ERR);
		return;
	}

	if (state == App_State::WAITING_FOR_INPUT)
	{
		print_line(STR_STOP_STATE_ERR);
		return;
	}

	print_line(STR_STOPING);

	// --- reset state for future calculations
	reset_state();

	// --- predict result using old generation
	memcpy(old_gen, gen, sizeof(Generation)); // cpy old_gen to current one

	gen->evaluate_gen(pm_avg()); // gen should already be evaluated, but to be sure
	float prediction = gen->get_best_chromosome()->predict(past_measurements[delta_counter % t_steps]);
	
	ftoa(prediction, out_buf, FLOAT_MAX_PRECISION); // out_buf is zeroed by reset_state();
	print_line(out_buf);

	delta_counter++; // using all prediction model for this delta, but considering it valid
}

void General::do_parameters_command()
{
	// prints parameters of gen regardless of state
	// --- prepare
	char num[SMALL_BUFF] = {0};
	float* params = gen->get_best_params();

	bzero(out_buf, LARGE_BUFF);

	// --- construct parameters string into out_buf + print
	for (int i = 0; i < PARAM_COUNT; i++)
	{
		ftoa(params[i], num, FLOAT_MAX_PRECISION);
		strncat(out_buf, Chromosome_NS::par_names[i], strlen(Chromosome_NS::par_names[i]));
		strncat(out_buf, " = ", strlen(" = "));
		strncat(out_buf, num, strlen(num));
		if (i < (PARAM_COUNT - 1)) strncat(out_buf, ", ", strlen(", "));
	}

	print_line(out_buf);
}

void General::start_calculate()
{	
	if (delta_counter < t_steps)
	{
		// add measurement to "past_measurements" even though nothing is calculating yet
		uint32_t delta_index = delta_counter % t_steps;
		past_measurements[delta_index] = measured_value;
		delta_counter++;

		print_line(STR_CALC_NAN_ERR);
		return;
	}

	if (gen_counter != 0) 
	{
		print_line(STR_CALC_CNTING_ERR);
		return; // cannot start calculate - a calculation is already on going
	}

	print_line(STR_CALCULATING);
	do_calculate();
}

void General::do_calculate()
{
	uint32_t delta_index = delta_counter % t_steps;

	// --- finish calculation
	if (gen_counter >= GENS_PER_DELTA)
	{
		// --- predict result using best chromosome
		// strncat(out_buf, "Prediction: ", strlen("Prediction: "));
		char num[SMALL_BUFF] = {0};
		float prediction = gen->get_best_chromosome()->predict(measured_value);
		
		bzero(out_buf, LARGE_BUFF);
		ftoa(prediction, num, FLOAT_MAX_PRECISION);
		strncat(out_buf, num, strlen(num));
		print_line(out_buf);

		// --- reset state, save results
		reset_state();
		delta_counter++; // inc delta_counter when calculation is done
		
		predicted_values[delta_index] = prediction;
		past_measurements[delta_index] = measured_value;
		memcpy(gen, old_gen, sizeof(Generation));

		return;
	}

	if (state != App_State::CALCULATING)
		state = App_State::CALCULATING;

	// several possibilities to evaluate gen: using measured value from t_pred ago, average of all t_deltas in t_pred
	// or either of those with predicted values (in t_pred)
	// gen->evaluate_gen(past_measurements[delta_index]);
	gen->evaluate_gen(pm_avg());
	gen->next_gen(next_gen);

	// fake workload to slow computation
	for (int i = 0; i < 8000000; i++)
		;

	// swap next_gen to gen (simple gen = next_gen would lose pointer)
	Generation *tmp = next_gen;
	next_gen = gen;
	gen = tmp;

	gen_counter++;
}