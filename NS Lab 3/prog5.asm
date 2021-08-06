.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
;msgfnt byte "%s",0Ah,0
;msg byte "Hello World", 0Ah, 0
output_msg1_format byte "%s", 0Ah, 0
output_msg3_format byte "%d", 0Ah, 0

output_msg1 byte "Enter count:", 0
output_msg2 byte "Enter the number", 0
output_msg3 byte "Total Sum:", 0

input_format byte "%d",0
number sdword ?
sum sdword 0
count sdword 0

.code
main proc
    INVOKE printf, ADDR output_msg1_format, ADDR output_msg1
    INVOKE scanf, ADDR input_format, ADDR count
    ;No need to push because we are not using any registers before calling them
    
    mov edx, count
    mov ebx, sum   
LOOP_:
    cmp edx, 0
    je EXIT_

    ;Always push registers into stack before calling functions as they can overwrite registers
    push edx 
    push ebx
    INVOKE printf, ADDR output_msg1_format, ADDR output_msg2
    INVOKE scanf, ADDR input_format, ADDR number
    pop ebx
    pop edx

    mov ecx, number
    add ebx, ecx
    sub edx, 1

    jmp LOOP_

EXIT_:
    mov sum, ebx

    ;No need to push because we are not using any registers after calling them
    INVOKE printf, ADDR output_msg1_format, ADDR output_msg3
    INVOKE printf, ADDR output_msg3_format, sum
    ret
main endp
end
