; File describing all methods I created for my final project
;

.model flat, stdcall ; why does this need to be here?
WriteString proto
Crlf proto
ReadChar proto
ReadString proto
WriteChar proto
ExitProcess proto,dwExitCode:dword


.data
gameoverMSG BYTE "GameOver.", 0

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
end