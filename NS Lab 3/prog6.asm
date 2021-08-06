.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Sdword, inputlist:VARARG

.data
    in1fmt byte "%d",0

    msg1fmt byte 0Ah,"%s",0
    msg1 byte "Enter the number: ",0

    msg2fmt byte 0Ah,"%s %d",0
    msg2 byte "Answer: ",0

    val1 dword ? ; number of volts
    val2 dword ? ; number of volts
    answer dword ?
.code
main PROC
    INVOKE scanf, ADDR in1fmt, ADDR val1
    INVOKE scanf, ADDR in1fmt, ADDR val2

    push val2 ;6
    push val1 ;3
    call AddTwo 
    pop val1
    pop val2
    ret
main ENDP

AddTwo PROC
    push ebp
    mov ebp, esp
    mov edx, [ebp+12]
    add edx, [ebp+8]
    mov answer, edx
    INVOKE printf, ADDR msg2fmt, ADDR msg2, answer
    pop ebp
    ret
AddTwo ENDP
END main