#include <std_lib.h>

#include <general.h>
#include <constants.h>


/**
 * @brief Glucouse prediction task - for predicting glucose levels using provided formula. This task
 * is controlled by UART.
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main(int argc, char** argv)
{
	General g;
	Input in;
	Res_Code rv = Res_Code::NO_ERR;
	
	//------ set up random number generator
	rand.open_rand();

	//------ set up uart
	uint32_t uart_file = g.setup_uart();

	//------ send welcome banner to uart (task number and name, name, personal number) and expected input
	g.print_welcome_banner();

	//------ read t_delta (whole number) from uart input - tells step on x-axis
	g.read_t_delta();

	//------ read t_pred (whole number) from uart input - prediction window - is a parameter for the model
	g.read_t_pred();

	//------ prepare GEA and everything to run the task
	g.init_defaults();
	rv =  g.setup_gea(); // allocs memory necessary to run
	g.print_val_command_request();

	if (rv != Res_Code::NO_ERR)
	{
		g.print_app_crash();
		return 1; // ideally should return Res_Code number
	}
		

	//------ indefinetly accept either: float number (starts new calculation) or commands: stop, parameters
	while (1) {
		switch (g.get_app_state())
		{
			// wait until a line is read. Calls "wait" which should block the process and put the cpu to power-saving mode
			case App_State::WAITING_FOR_INPUT:
				g.prompt_user_input();
				in = g.read_val_or_command_blocking();
				break;
			// reads input but continues if there is not a line on it
			case App_State::CALCULATING:
				in = g.read_val_or_command();
				g.do_calculate();
				break;
			// this shouldn't occur 
			default:
				g.reset_state();
				break;
		}

		switch (in)
		{
			case Input::STOP_CMD:
				g.do_stop_command();
				break;
			case Input::PARAM_CMD:
				g.do_parameters_command();
				break;
			case Input::FLOAT_IN:
				g.start_calculate();
				break;
			case Input::ERR:
				g.print_line(STR_INPUT_ERR);
				break;
			case Input::NO_INPUT:
				// nothing to do - this is reached when calculation is in progress but there is no Input to handle
				break;
			default:
				g.print_line(STR_REACHED_DEF_ERR);
				break;
		}
	}

    return 0;
}