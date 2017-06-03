.386
.model flat,stdcall
.stack 4096

ExitProcess proto,dwExitCode:dword
WriteString proto
WriteDec proto
Crlf proto
writeLine proto
getDoor proto
gameOver proto
getYesOrNo proto
SetTextColor proto

.data
MAX = 20
welcomeMSG BYTE "Welcome to the Room of Quite a Few Doors.", 0
getDecisionMSG BYTE "Inspect room?", 0
getDoorMSG BYTE "Go in West (w), North(n), or East(e) door?", 0
crystalMSG BYTE "Number of Crystals: ", 0
userInput BYTE MAX+1 DUP (?)
inByte BYTE ?
roomDebug BYTE 0
numCrystals DWORD 0

.code
main proc
	;; text setup
	mov eax, 11112222
	call SetTextColor

	mov	edx, offset welcomeMSG			
	call writeLine

	gameLoop:
	; just to make sure you are moving through the rooms
	mov al, roomDebug
	mov al, 1
	mov roomDebug, al

	;; output number of crystals
	mov edx, offset crystalMSG
	call WriteString
	mov eax, numCrystals
	call WriteDec
	call Crlf

	;; inspect room or no?
	mov edx, offset getDecisionMSG
	call writeLine

	call getYesOrNo ;; answer in al

	cmp al, 'n' ; if no skip to door picking
	jz doorPicking

	; This section for inspecting the room
	;
	;
	;
	;
	;

	doorPicking:
	;;get dialogue
	mov edx, offset getDoorMSG
	call writeLine
	
	;; get input
	call getDoor

	;; do calculations

	;; add a victory msg once 10 is found
	mov eax, numCrystals
	cmp eax, 10
	jb gameLoop

	; just incase
	call gameOver
main endp
end main

