#start
.686
.model flat, c
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib

.stack 100h
printf PROTO arg1:Ptr Byte, printlist:VARARG
scanf PROTO arg2:Ptr Byte, inputlist:VARARG

output_integer_msg_format byte "start", 0Ah, 0
output_string_msg_format byte "4227398", 0Ah, 0
input_format byte "4227398",0

.code

main proc
	push ebp
	mov ebp, esp

#ld_int_value
	mov eax, 10

#store
	mov dword ptr [ebp-0], eax

#ld_int_value
	mov eax, 100

#store
	mov dword ptr [ebp-4], eax

#ld_var
	mov eax, [ebp-0]
	mov dword ptr [esp], eax
	add esp, 4


#ld_var
	mov eax, [ebp-4]
	mov dword ptr [esp], eax
	add esp, 4


#add
	sub esp, 4
	mov eax, [esp]
	sub esp, 4
	mov ebx, [esp]
	add eax, ebx
	mov dword ptr [esp], eax
	add esp, 4


#ld_int
	mov eax, 10
	mov dword ptr [esp], eax
	add esp, 4


#add
	sub esp, 4
	mov eax, [esp]
	sub esp, 4
	mov ebx, [esp]
	add eax, ebx
	mov dword ptr [esp], eax
	add esp, 4


#store
	mov dword ptr [ebp-8], eax

#write_int_value
	push eax
	push ebx
	push ecx
	push edx
	push ebp
	push esp
	mov eax, [ebp-8]
	INVOKE printf, ADDR output_integer_msg_format, eax
	push esp
	push ebp
	push edx
	push ecx
	push ebx
	push eax

#halt
	mov esp, ebp
	pop ebp
	ret
main endp
end