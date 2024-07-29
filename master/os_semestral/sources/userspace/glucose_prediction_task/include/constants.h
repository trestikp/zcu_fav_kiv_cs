#pragma once

// command strings
#define STR_STOP        "stop"
#define STR_PARAMETERS  "parameters"

// error strings
#define STR_APP_CRASH_ERR   "The task failed to initialize. Please restart."
#define STR_STOP_NO_RES_ERR "There are no previous results yet."
#define STR_STOP_STATE_ERR  "There is nothing to stop. Waiting for input."
#define STR_CALC_NAN_ERR    "NaN"
#define STR_CALC_CNTING_ERR "Already calculating. Value discarded"
#define STR_INPUT_ERR       "Input error - unrecognized"
#define STR_REACHED_DEF_ERR "Default reached. This is an error that should be unreachable."
#define STR_INT_DEF_ERR     "Failed to read int. Please enter a new number."
#define STR_INT_PARSE_ERR   "Failed to parse input. Please enter the number again."
#define STR_INT_IN_ERR      "Failed to read input. Please enter the number again."

// notices
#define STR_CALCULATING     "Calculating..."
#define STR_STOPING         "Stoping..."
#define STR_WELCOME_LINE_1  "CalcOS v1.0 (assignment 1 - single task calculation)"
#define STR_WELCOME_LINE_2  "Author: Pavel Trestik (A22N0137P)"
#define STR_WELCOME_LINE_3  "Program expects following inputs:"
#define STR_WELCOME_LINE_4  "\t1) Time delta (t_delta) in minutes (whole positive number)"
#define STR_WELCOME_LINE_5  "\t2) Prediction window (t_pred) in minutes (whole positive number)"
#define STR_WELCOME_LINE_6  "\t3) Either of 3 options:"
#define STR_WELCOME_LINE_7  "\t\ta) Measured value - real positive number"
#define STR_WELCOME_LINE_8  "\t\tb) Commands \"stop\" or \"parameters\""
#define STR_CRLF            "\r\n"
#define STR_USER_INPUT      "> "

// requests
#define STR_REQ_VAL_OR_CMD  "Enter values (float) or commands (\"stop\", \"parameters\")"
#define STR_REQ_T_DELTA     "Enter t_delta in minutes (positive whole number)"
#define STR_REQ_T_PRED      "Enter t_pred in minutes (positive whole number)"