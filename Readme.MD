These are all problems from https://quicksilicon.in/ courses. 
You should check those out and then if you are unable to solve come here for a solution.

THIS HAS BEEN MY GENERAL APPROACH FOR DIVISIBILITY BY ANY NUMBER:
1. CREATE FSM WITH N STATES (FROM 0 TO N-1) FOR DIVISIBILITY BY N.
2. CHECK FOR REMAINDERS AT THE END OF EVERY INPUT BIT. 
3. WHILE ACCEPTING NEXT INPUT BIT YOUR LOGIC CHANGES: BECAUSE YOU DO A LEFT SHIFT OF PREV INPUT: next_state = (2*remainder of current state + x_i) modN
4. FINALLY ASSIGN ISDIVISIBLE SIGNAL TO THE CURRENT STATE. (DEFAULT STATE ON RESET SHOULD BE S0 in short is divisible)


