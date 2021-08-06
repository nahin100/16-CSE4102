; x86 - 32 bit assembly
; x86_64 - 64 bit assembly
; ax = 16 bits
; edx = 32 bits
; rax = 64 bits
.686 ; Pentium or below processors
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte

.data
msg byte "Hello World", 0Ah, 0

.code
main proc
    INVOKE printf, ADDR msg
    ret
main endp
end










