{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww34360\viewh21600\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 .data\
    result_msg: .asciz "Your letter grade is: "\
\
.text\
.global main\
\
main:\
    @ Ask the user for the percentage grade\
    mov r0, #1\
    ldr r1, =msg\
    mov r2, #100\
    mov r7, #0\
    svc #0\
\
    @ Convert the input (string) to an integer\
    mov r5, #0  @ Initialize percentage grade to 0\
    mov r6, #10 @ Set the base (decimal)\
\
convert_loop:\
    @ Load the next character from the input string into r3\
    ldrb r3, [r1]\
\
    @ Check if the character is null (end of string)\
    cmp r3, #0\
    beq end_convert_loop\
\
    @ Convert the character to an integer value (subtract ASCII '0')\
    sub r3, r3, #'0'\
\
    @ Check if the character is a valid digit (0-9)\
    cmp r3, #9\
    ble valid_digit\
    b invalid_digit\
\
valid_digit:\
    @ Update the percentage grade (multiply by the base and add the digit value)\
    mul r5, r5, r6\
    add r5, r5, r3\
\
    @ Move to the next character in the string\
    add r1, r1, #1\
    b convert_loop\
\
invalid_digit:\
    @ Handle the case where the input string contains invalid characters\
    @ For simplicity, we just set the percentage grade to -1 (an invalid value)\
    mov r5, #-1\
\
end_convert_loop:\
\
    @ Compare the percentage grade with the grade thresholds\
    @ and print the corresponding message\
    cmp r5, #90\
    bge grade_A_check\
\
    cmp r5, #75\
    bge grade_B_check\
\
    cmp r5, #50\
    bge grade_C_check\
\
    @ If none of the conditions match, print "Sorry, you got an F."\
    ldr r0, =SORRY_MSG\
    bl print_string\
    b end_program\
\
grade_A_check:\
    @ If the percentage grade is >= 90, print "Congratulations! You got an A."\
    ldr r0, =CONGRATULATIONS_MSG\
    bl print_string\
    b end_program\
\
grade_B_check:\
    @ If the percentage grade is >= 75 && < 90, print "Good job! You got a B."\
    ldr r0, =GOOD_JOB_MSG\
    bl print_string\
    b end_program\
\
grade_C_check:\
    @ If the percentage grade is >= 50 && < 75, print "Not bad, you got a C."\
    ldr r0, =NOT_BAD_MSG\
    bl print_string\
\
end_program:\
    @ Terminate the program\
    mov r7, #1   @ syscall number for sys_exit (1)\
    mov r0, #0   @ exit status 0 (success)\
    svc #0\
\
.data\
CONGRATULATIONS_MSG: .asciz "Congratulations! You got an A.\\n"\
GOOD_JOB_MSG: .asciz "Good job! You got a B.\\n"\
NOT_BAD_MSG: .asciz "Not bad, you got a C.\\n"\
SORRY_MSG: .asciz "Sorry, you got an F.\\n"\
msg: .space 100\
}