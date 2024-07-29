import { basename } from 'path/posix';
import {
    Instruction,
    InstructionType,
    InstructionStepParameters,
    Stack,
    StackItem,
    StackFrame,
    OperationType,
} from './model';

import {
    FreeDummy,
    AllocateDummy,
    GetValueFromHeapDummy,
    PutValueOnHeapDummy,
} from './allocator';

import i18next from 'i18next';

// ------------------------------------------- INTERFACES

export interface Explanation {
    message: string;
    placeholders: Placeholder[];
}

export interface Placeholder {
    // What placeholder in message to replace
    placeholder: string;
    // Value to replace it with
    value: number;

    // Which values to highlight in stack
    stack: number[];
    // Which values to highlight in heap
    heap: number[];
    // Which instructions to highlight
    instructions: number[];

    //base: boolean;

    // Whether or not to highlight the LEVEL in instruction GUI
    level: boolean;
    // Whether or not to highlight the PARAMETER in instruction GUI
    parameter: boolean;
    // Whether or not to highlight the input field
    output: boolean;
    // Whether or not to highlight the output field
    input: boolean;
    // How to highlight - BOLD or BACKGROUND
    highlightType: HighlightType;
}

export enum HighlightType {
    BOLD,
    BACKGROUND,
}

// ------------------------------------------- INTERFACES

// ------------------------------------------- STACK UTILITY FUNCTIONS

function GetValuesFromStack(
    stack: Stack,
    index: number,
    count: number,
    decrementCurrentFrame: boolean = false
): number[] {
    let retvals: number[] = [];
    for (let i = 0; i < count; i++) {
        if (!CheckSPInBounds(index - i)) {
            throw new Error(i18next.t('core:modelStackNegativeError'));
        }
        retvals.push(stack.stackItems[index - i].value);
    }
    return retvals;
}

// Checks if SP is not pointing under the stack
function CheckSPInBounds(sp: number) {
    if (sp < 0) {
        return false;
    } else {
        return true;
    }
}

function FindBaseDummy(stack: Stack, base: number, level: number): number[] {
    let newBase = base;
    let levels = [base];
    while (level > 0) {
        newBase = stack.stackItems[newBase].value;
        level--;
        levels.push(newBase);
        if (newBase == 0 && level != 0) {
            return [-1];
        }
    }

    return levels;
}

// ------------------------------------------- STACK UTILITY FUNCTIONS

// ------------------------------------------- EXPLAINER

export function ExplainInstruction(params: InstructionStepParameters): Explanation {
    let instruction = params.instructions[params.model.pc];
    let op = instruction.instruction;
    let level = instruction.level;
    let parameter = instruction.parameter;

    let heap = params.model.heap;
    let stack = params.model.stack;

    let explanation: Explanation = {
        message: '',
        placeholders: [],
    };

    switch (op) {
        case InstructionType.LIT:
            explanation.message = i18next.t('core:explainerLIT');
            explanation.placeholders.push({
                placeholder: '1',
                value: parameter,
                heap: [],
                stack: [],
                instructions: [],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case InstructionType.OPR:
            explanation = ExplainOPR(stack, parameter, params.model.sp);
            break;
        case InstructionType.INT:
            explanation.message = i18next.t('core:explainerINT');
            explanation.placeholders.push({
                placeholder: '1',
                value: parameter,
                heap: [],
                stack: [],
                instructions: [],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case InstructionType.JMP:
            explanation.placeholders.push({
                placeholder: '1',
                value: parameter,
                heap: [],
                stack: [],
                instructions: [],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            if (parameter >= params.instructions.length) {
                explanation.message = i18next.t('core:explainerJMPErr');
            } else {
                explanation.message = i18next.t('core:explainerJMP');
                explanation.placeholders[0].instructions.push(parameter);
            }
            break;
        case InstructionType.JMC:
            if (stack.stackItems[params.model.sp].value == 0) {
                if (parameter >= params.instructions.length) {
                    explanation.message = i18next.t('core:explainerJMCNonExistent');
                    explanation.placeholders.push({
                        placeholder: '1',
                        value: stack.stackItems[params.model.sp].value,
                        heap: [],
                        stack: [params.model.sp],
                        instructions: [],
                        level: false,
                        parameter: false,
                        output: false,
                        input: false,
                        highlightType: HighlightType.BOLD,
                    });
                    explanation.placeholders.push({
                        placeholder: '2',
                        value: parameter,
                        heap: [],
                        stack: [],
                        instructions: [],
                        level: false,
                        parameter: true,
                        output: false,
                        input: false,
                        highlightType: HighlightType.BOLD,
                    });
                } else {
                    explanation.message = i18next.t('core:explainerJMCJump');
                    explanation.placeholders.push({
                        placeholder: '1',
                        value: stack.stackItems[params.model.sp].value,
                        heap: [],
                        stack: [params.model.sp],
                        instructions: [],
                        level: false,
                        parameter: false,
                        output: false,
                        input: false,
                        highlightType: HighlightType.BOLD,
                    });
                    explanation.placeholders.push({
                        placeholder: '2',
                        value: parameter,
                        heap: [],
                        stack: [params.model.sp],
                        instructions: [parameter],
                        level: false,
                        parameter: false,
                        output: false,
                        input: false,
                        highlightType: HighlightType.BOLD,
                    });
                }
                explanation.message;
            } else {
                explanation.message = i18next.t('core:explainerJMCDontJump');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: stack.stackItems[params.model.sp].value,
                    heap: [],
                    stack: [params.model.sp],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BOLD,
                });
            }
            break;
        case InstructionType.CAL:
            if (parameter >= params.instructions.length) {
                explanation.message = i18next.t('core:explainerCALOutOfBoundsInstr');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: parameter,
                    heap: [],
                    stack: [],
                    instructions: [],
                    level: false,
                    parameter: true,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BOLD,
                });
                break;
            }

            let levels = FindBaseDummy(stack, params.model.base, level);
            if (levels[0] == -1) {
                explanation.message = i18next.t('core:explainerLevelTooHigh');
                break;
            }
            explanation.message =
                i18next.t('core:explainerCALOk1') +
                (params.model.pc + 1) +
                i18next.t('core:explainerCALOk2');
            explanation.placeholders.push({
                placeholder: '1',
                value: parameter,
                heap: [],
                stack: [],
                instructions: [parameter],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '2',
                value: params.model.base,
                heap: [],
                stack: [params.model.base],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '3',
                value: levels[levels.length - 1],
                heap: [],
                stack: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            for (let i = 0; i < levels.length; i++) {
                explanation.placeholders[2].stack.push(levels[i]);
            }
            break;
        case InstructionType.RET:
            if (params.model.base == 0) {
                explanation.message = i18next.t('core:explainerRETEnd');
                break;
            }

            explanation.message = i18next.t('core:explainerRET');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[params.model.base + 2].value,
                heap: [],
                stack: [params.model.base + 2],
                instructions: [stack.stackItems[params.model.base + 2].value],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[params.model.base + 1].value,
                heap: [],
                stack: [params.model.base + 1],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '3',
                value: params.model.base - 1,
                heap: [],
                stack: [params.model.base - 1],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case InstructionType.LOD:
            let bases = FindBaseDummy(stack, params.model.base, level);
            if (bases[0] == -1) {
                explanation.message = i18next.t('core:explainerLevelTooHigh');
                break;
            }

            var address = bases[bases.length - 1] + parameter;

            let tmp;
            if (address > stack.stackItems.length - 1) {
                tmp = 0;
            } else {
                tmp = stack.stackItems[address].value;
            }

            explanation.message =
                i18next.t('core:explainerLOD1') +
                address +
                i18next.t('core:explainerLOD2') +
                tmp +
                i18next.t('core:explainerLOD3');
            explanation.placeholders.push({
                placeholder: '1',
                value: level,
                heap: [],
                stack: [],
                instructions: [],
                level: true,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            for (let i = 0; i < bases.length; i++) {
                explanation.placeholders[0].stack.push(bases[i]);
            }
            explanation.placeholders.push({
                placeholder: '2',
                value: parameter,
                heap: [],
                stack: [address],
                instructions: [],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            break;
        case InstructionType.STO:
            bases = FindBaseDummy(stack, params.model.base, level);
            if (bases[0] == -1) {
                explanation.message = i18next.t('core:explainerLevelTooHigh');
                break;
            }

            var address = bases[bases.length - 1] + parameter;

            if (address < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                break;
            }

            explanation.message = i18next.t('core:explainerSTO') + address + ')';
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[params.model.sp].value,
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '2',
                value: level,
                heap: [],
                stack: [],
                instructions: [],
                level: true,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            for (let i = 0; i < bases.length; i++) {
                explanation.placeholders[1].stack.push(bases[i]);
            }
            explanation.placeholders.push({
                placeholder: '3',
                value: parameter,
                heap: [],
                stack: [address],
                instructions: [],
                level: false,
                parameter: true,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case InstructionType.WRI:
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[params.model.sp].value,
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (
                stack.stackItems[params.model.sp].value < 0 ||
                stack.stackItems[params.model.sp].value > 255
            ) {
                explanation.message = i18next.t('core:explainerWRIAsciiErr');
            } else {
                explanation.message =
                    i18next.t('core:explainerWRI') +
                    String.fromCharCode(stack.stackItems[params.model.sp].value);
            }
            break;
        case InstructionType.REA:
            if (params.input.length == 0) {
                explanation.message = i18next.t('core:explainerREAInputEmpty');
            } else {
                explanation.message =
                    i18next.t('core:explainerREA') +
                    params.input.at(0) +
                    ' (' +
                    params.input.charCodeAt(0) +
                    ')';
            }
            break;
        case InstructionType.NEW:
            var count = stack.stackItems[params.model.sp].value;
            explanation.placeholders.push({
                placeholder: '1',
                value: count,
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (count <= 0 || count > params.model.heap.size) {
                explanation.message = i18next.t('core:explainerNEWInvalidArg');
            } else {
                let res = AllocateDummy(heap, count);
                if (res == -1) {
                    explanation.message = i18next.t('core:explainerNEWNoFreeSpace');
                } else {
                    explanation.message = i18next.t('core:explainerNEW');
                    explanation.placeholders.push({
                        placeholder: '2',
                        value: res,
                        heap: [],
                        stack: [],
                        instructions: [],
                        level: false,
                        parameter: false,
                        output: false,
                        input: false,
                        highlightType: HighlightType.BACKGROUND,
                    });
                    for (let i = 0; i < count; i++) {
                        explanation.placeholders[1].heap.push(res + i);
                    }
                }
            }
            break;
        case InstructionType.DEL:
            var addr = stack.stackItems[params.model.sp].value;
            let res = FreeDummy(heap, addr);

            if (res == -1) {
                explanation.message = i18next.t('core:explainerDELError');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: addr,
                    heap: [],
                    stack: [params.model.sp],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BOLD,
                });
            } else {
                explanation.message = i18next.t('core:explainerDEL');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: res,
                    heap: [],
                    stack: [],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BOLD,
                });
                explanation.placeholders.push({
                    placeholder: '2',
                    value: addr,
                    heap: [],
                    stack: [],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BACKGROUND,
                });
                for (let i = 0; i < res; i++) {
                    explanation.placeholders[1].heap.push(addr + i);
                }
            }

            break;
        case InstructionType.LDA:
            var addr = stack.stackItems[params.model.sp].value;
            explanation.placeholders.push({
                placeholder: '1',
                value: addr,
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            if (addr < 0 || addr >= heap.size) {
                explanation.message = i18next.t('core:explainerLDAOutOfBounds');
            } else {
                let res = GetValueFromHeapDummy(heap, addr);
                if (res === null) {
                    explanation.message = i18next.t('core:explainerLDAOutOfBounds');
                } else if (Number.isNaN(res)) {
                    explanation.message = i18next.t('core:explainerLDAUnallocated');
                    explanation.placeholders[0].highlightType = HighlightType.BACKGROUND;
                    explanation.placeholders[0].heap.push(addr);
                } else {
                    explanation.message = i18next.t('core:explainerLDA');
                    explanation.placeholders[0].highlightType = HighlightType.BACKGROUND;
                    explanation.placeholders[0].heap.push(addr);
                }
            }
            break;
        case InstructionType.STA:
            if (params.model.sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                return explanation;
            }

            var addr = stack.stackItems[params.model.sp - 1].value;
            var val = stack.stackItems[params.model.sp].value;
            var temp = PutValueOnHeapDummy(heap, addr);

            if (temp == -2) {
                explanation.message = i18next.t('core:explainerSTAUnallocated');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: addr,
                    heap: [addr],
                    stack: [params.model.sp - 1],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BACKGROUND,
                });
            } else if (temp == -1) {
                explanation.message = i18next.t('core:explainerSTAOutOfBounds');
            } else {
                explanation.message = i18next.t('core:explainerSTA');
                explanation.placeholders.push({
                    placeholder: '1',
                    value: val,
                    heap: [],
                    stack: [params.model.sp],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BOLD,
                });
                explanation.placeholders.push({
                    placeholder: '2',
                    value: addr,
                    heap: [addr],
                    stack: [params.model.sp - 1],
                    instructions: [],
                    level: false,
                    parameter: false,
                    output: false,
                    input: false,
                    highlightType: HighlightType.BACKGROUND,
                });
            }
            break;
        case InstructionType.PLD:
            var values: number[] = GetValuesFromStack(stack, params.model.sp, 2);
            bases = FindBaseDummy(stack, params.model.base, values[1]);
            if (bases[0] == -1) {
                explanation.message = i18next.t('core:explainerLevelTooHigh');
                break;
            }

            if (bases[bases.length - 1] + values[0] > stack.stackItems.length - 1) {
                tmp = 0;
            } else {
                tmp = stack.stackItems[bases[bases.length - 1] + values[0]].value;
            }

            explanation.message =
                i18next.t('core:explainerLOD1') +
                i18next.t('core:explainerLOD2') +
                tmp +
                i18next.t('core:explainerLOD3');

            explanation.placeholders.push({
                placeholder: '1',
                value: values[1],
                heap: [],
                stack: [params.model.sp - 1],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            for (let i = 0; i < bases.length; i++) {
                explanation.placeholders[0].stack.push(bases[i]);
            }
            explanation.placeholders.push({
                placeholder: '2',
                value: values[0],
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '3',
                value: bases[bases.length - 1] + values[0],
                heap: [],
                stack: [bases[bases.length - 1] + values[0]],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case InstructionType.PST: // TODO PST
            var values: number[] = GetValuesFromStack(stack, params.model.sp, 3);
            bases = FindBaseDummy(stack, params.model.base, values[1]);
            if (bases[0] == -1) {
                explanation.message = i18next.t('core:explainerLevelTooHigh');
                break;
            }

            explanation.message = i18next.t('core:explainerPST');

            explanation.placeholders.push({
                placeholder: '1',
                value: values[2],
                heap: [],
                stack: [params.model.sp - 2],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '2',
                value: values[1],
                heap: [],
                stack: [params.model.sp - 1],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            for (let i = 0; i < bases.length; i++) {
                explanation.placeholders[1].stack.push(bases[i]);
            }
            explanation.placeholders.push({
                placeholder: '3',
                value: values[0],
                heap: [],
                stack: [params.model.sp],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            explanation.placeholders.push({
                placeholder: '4',
                value: bases[bases.length - 1] + values[0],
                heap: [],
                stack: [bases[bases.length - 1] + values[0]],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            break;
        default:
            throw new Error(i18next.t('core:modelNonExistentInstructionError'));
    }

    if (params.model.pc + 1 >= params.instructions.length) {
        if (op == InstructionType.JMC) {
            if (stack.stackItems[params.model.sp].value != 0) {
                explanation.message = i18next.t('core:explainerEndNoJump');
            }
        } else if (
            op != InstructionType.CAL &&
            op != InstructionType.JMP &&
            op != InstructionType.RET
        ) {
            explanation = {
                placeholders: [],
                message: i18next.t('core:explainerEndNoMoreInstructions'),
            };
        }
    }

    return explanation;
}

function ExplainOPR(stack: Stack, operation: number, sp: number): Explanation {
    let e_op = operation as OperationType;
    let explanation: Explanation = { message: '', placeholders: [] };

    if (sp < 0) {
        explanation.message = i18next.t('core:modelStackNegativeError');
        return explanation;
    }

    switch (e_op) {
        case OperationType.U_MINUS:
            explanation.message = i18next.t('core:explainerOPR1');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.ADD:
            explanation.message = i18next.t('core:explainerOPR2');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.SUB:
            explanation.message = i18next.t('core:explainerOPR3');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.MULT:
            explanation.message = i18next.t('core:explainerOPR4');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.DIV:
            explanation.message = i18next.t('core:explainerOPR5');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
            break;
        case OperationType.MOD:
            explanation.message = i18next.t('core:explainerOPR6');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
            break;
        case OperationType.IS_ODD:
            explanation.message = i18next.t('core:explainerOPR7');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.EQ:
            explanation.message = i18next.t('core:explainerOPR8');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.N_EQ:
            explanation.message = i18next.t('core:explainerOPR9');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.LESS_THAN:
            explanation.message = i18next.t('core:explainerOPR10');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.MORE_EQ_THAN:
            explanation.message = i18next.t('core:explainerOPR11');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.MORE_THAN:
            explanation.message = i18next.t('core:explainerOPR12');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        case OperationType.LESS_EQ_THAN:
            explanation.message = i18next.t('core:explainerOPR13');
            explanation.placeholders.push({
                placeholder: '1',
                value: stack.stackItems[sp].value,
                stack: [sp],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });

            if (sp - 1 < 0) {
                explanation.message = i18next.t('core:modelStackNegativeError');
                explanation.placeholders = [];
                return explanation;
            }

            explanation.placeholders.push({
                placeholder: '2',
                value: stack.stackItems[sp - 1].value,
                stack: [sp - 1],
                heap: [],
                instructions: [],
                level: false,
                parameter: false,
                output: false,
                input: false,
                highlightType: HighlightType.BOLD,
            });
            break;
        default:
            explanation.message = i18next.t('core:modelUnknownOPR');
    }

    return explanation;
}
