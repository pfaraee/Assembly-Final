; File describing all methods I created for my final project
;

.model flat, stdcall ; why does this need to be here?
WriteString proto
Crlf proto
ReadChar proto
ReadString proto
OpenInputFile proto
ReadFromFile proto
WriteChar proto
CloseFile proto
StrLength proto
WriteInt proto
RandomRange proto
Str_copy proto
Randomize proto
WriteWindowsMsg proto
ExitProcess proto,dwExitCode:dword


.data
gameoverMSG BYTE "GameOver.", 0
descriptionFile BYTE "C:\Irvine\Irvine\Final_Project\Text.txt", 0
filehandle DWORD ?
BUFSIZE = 5000
buffer BYTE BUFSIZE DUP(?)
descriptionString BYTE BUFSIZE + 1 DUP(?)
bytesRead DWORD ?


.code
; method to write string to line
; put string offset in edx 
writeLine proc
	call WriteString
	call Crlf

	ret
writeLine endp

; method to get valid user input onw which door to choose
; puts input char in al
; game over if input is invalid
getDoor proc
	call ReadChar

	cmp al, 'w'
	jz validDoor

	cmp al, 'n'
	jz validDoor

	cmp al, 'e'
	jz validDoor

	call gameOver

	validDoor: ret
getDoor endp

getYesOrNo proc
	call ReadChar

	cmp al, 'y'
	jz good
	
	cmp al, 'n'
	jz good

	call gameOver

	good: ret
getYesOrNo endp

; function that ends the game
gameOver proc
	mov edx, offset gameoverMSG
	call writeLine

	invoke ExitProcess,0
gameOver endp

getDescription proc
	mov edx, offset descriptionFile
	call OpenInputFile
	mov filehandle, eax
	mov edx, offset buffer
	mov ecx, BUFSIZE
	call ReadFromFile
	jc show_error_message

	mov bytesRead, eax

	mov eax, 3
	call Randomize
	call RandomRange
	inc eax ; incs so its beween 1 and n now
	mov ebx, eax ; moves it because we use ebx in getStringFromBuffer

	call getStringFromBuffer
	call writeLine

	

	mov eax, filehandle
	call CloseFile

	ret

	show_error_message:
	call WriteWindowsMsg
getDescription endp

;; GETS NTH LINE STORED IN EBX, POINTS ESI TO THE ADRESS OF THE LINE
;; STORES ADDRES INTO EDX
;; uses ebx for the index starting at 1
getStringFromBuffer proc
	mov esi, offset buffer ; MAYBE JUST GET RID OF THIS SOON
	mov ecx, ebx ; counter

L1:	
	mov edx, esi
	call StrLength ;stored in eax
	add esi, eax ; adds length
	inc esi ; ADDS ONE TO SKILL THE NULLCHAR
	; NOW ESI POINTS TO THE STRING I WANT
	loop L1

	mov edx, esi

	ret
getStringFromBuffer endp
end