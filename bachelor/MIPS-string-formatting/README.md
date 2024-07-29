This is a semestral work for KIV/UPA @ ZCU. (2019)

# MIPS-string-formatting
Simple string formatting in MIPS. More in README

<b>ukol2.s</b><br>
As said above. Is a simple program which prompts the user to add a string and then modify it
with the use of instructions d and i. <br>
Instruction d\<position\> - deletes char at \<position\>. <br>
Instruction i\<position\>\<char\> - inserts \<char\> at \<position\>. <br>
!! \<position\> is an index of said char! not its number. <br>
i.e. input = "hello" <br>
instr: d1 -> "hllo" <br>
instr: i1e -> "hello" <br>

instr: e (or anything beggining with 'e') ends the program.



This program isn't completely fool proof and almost certainly has bugs and things to improve.
It was more or less my first time writing a program in assembly and it probably looks that way.
There is probably a lot of improvements possible on the code, but maybe it can help another 
noob like me.

<b>Note</b>
Simulator used QtSpim. The syscall codes are similar in other simulators I've seen tho.

<b>ukol1.circ</b><br>
Is a circuit done in Logism. It only simulates simple 5 state automat.
It's just my backup for the whole subject so it's there.
