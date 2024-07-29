import React, { useEffect, useState } from 'react';
import {
    InstructionsHighligting,
    InstructionsToBeHighlighted,
} from '../../core/highlighting';
import { Instruction, InstructionType } from '../../core/model';
import { InstructionExplanation } from './InstructionExplanation';

type InstructionItemViewProps = {
    instruction: Instruction;
    hasError: boolean;
    hasBreakpoint: boolean;
    isNext: boolean;

    instructionsToBeHighlighted: InstructionsHighligting | null;
};
export function InstructionItemView(props: InstructionItemViewProps) {
    const highlightedRow = props.isNext
        ? props.instructionsToBeHighlighted?.rowColors.has(props.instruction.index)
            ? props.instructionsToBeHighlighted?.rowColors.get(props.instruction.index)
            : null
        : null;
    const highlightedPar = props.isNext
        ? props.instructionsToBeHighlighted?.parameter ?? null
        : null;
    const highlightedLevel = props.isNext
        ? props.instructionsToBeHighlighted?.level ?? null
        : null;

    return (
        <tr
            style={
                props.isNext
                    ? {
                          backgroundColor: 'white',
                          borderLeft: '3px solid green',
                      }
                    : {}
            }
        >
            <td
                style={
                    highlightedRow
                        ? {
                              backgroundColor: highlightedRow,
                              color: 'black',
                          }
                        : {}
                }
            >
                {props.instruction.index}
            </td>
            <td>{InstructionType[props.instruction.instruction]}</td>
            <td
                style={
                    highlightedLevel
                        ? {
                              backgroundColor: highlightedLevel,
                          }
                        : {}
                }
            >
                {props.instruction.level}
            </td>
            <td
                style={
                    highlightedPar
                        ? {
                              backgroundColor: highlightedPar,
                          }
                        : {}
                }
            >
                {props.instruction.parameter}
            </td>

            <td>
                <InstructionExplanation
                    explanationParts={props.instruction.explanationParts ?? []}
                    isNext={props.isNext}
                />
            </td>
        </tr>
    );
}
