; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
WriteDec proto

.code
main proc
	mov	eax,5				
	add	eax,6				

	call WriteDec
	invoke ExitProcess,0
main endp
end main