.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

.data
output_integer_msg_format byte "%s", 0Ah, 0
output_string_msg_format byte "%d", 0Ah, 0
input_format byte "%d",0

number sdword ?
sum sdword 0
count sdword 0

.code
main proc
    push ebp
    mov ebp, esp

    mov eax, 5
    mov dword ptr [ebp-4], eax

    mov eax, 2
    mov dword ptr [ebp-8], eax

    mov eax, 10
    mov dword ptr [ebp-12], eax

    mov eax, 0
    mov dword ptr [ebp-16], eax

    ;mov eax, [ebp-12]
    ;INVOKE printf, ADDR output_integer_msg_format, eax

    mov eax, [ebp-12]
    mov dword ptr [esp], eax
    add esp, 4

    mov eax, [ebp-8]
    mov dword ptr [esp], eax
    add esp, 4

    sub esp, 4
    mov eax, [esp]
    sub esp, 4
    mov ebx, [esp]
    add eax, ebx
    mov dword ptr [esp], eax
    add esp, 4

    mov eax, [ebp-4]
    mov dword ptr [esp], eax
    add esp, 4

    sub esp, 4
    mov eax, [esp]
    sub esp, 4
    mov ebx, [esp]
    add eax, ebx
    mov dword ptr [esp], eax
    add esp, 4

    sub esp, 4
    mov eax, [esp]
    mov dword ptr [ebp-16], eax

    push eax
    push ebx
    push ecx
    push edx
    push ebp
    push esp
    mov eax, [ebp-16]
    INVOKE printf, ADDR output_integer_msg_format, eax
    pop esp
    pop ebp
    pop edx
    pop ecx
    pop ebx
    pop eax

    mov esp, ebp
    pop ebp
    ret
main endp
end
