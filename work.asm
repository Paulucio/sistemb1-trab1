segment code
..start:
; iniciar os registros de segmento DS e SS e o ponteiro de pilha SP
mov ax,data
mov ds,ax
mov ax,stack
mov ss,ax
mov sp,stacktop

;INICIO DO CODIGO

mov dx, ARQUIVO 	; coloca o endereço do nome do arquivo em dx
mov al,2 		; modo de acesso - leitura e escrita
mov ah,3Dh 		; função 3Dh - abre um arquivo
int 21h 		; chama serviço do DOS
mov [HANDLER],ax 		; guarda o manipulador do arquivo para mais tarde

LE_PIX: ;Le um pixel do arquivo
    xor di,di
    xor si,si
    mov di, BUFFER
    mov si, PIXEL

    LEITURA:
        mov dx, di 	; endereço do buffer em dx
        mov bx,[HANDLER] ; manipulador em bx
        mov cx,1 		; quantidade de bytes a serem lidos
        mov ah,3Fh 		; função 3Fh - leitura de arquivo
        int 21h 		; chama serviço do DOS

        mov dl, byte[di] ; move para dl o valor lido
        cmp dl, 20h      ;verifica se e espaco
        je FIM_PIX       ;se for espaco vai termina a leitura do pixel

        mov [si], dl     ;se nao entrar no jump salva leitura para ler o proximo
        add si, 1        ;incrementa o ponteiro para a proxima posicao
        jmp LEITURA

FIM_PIX:
mov byte[si], 24h ;coloca $ para indicar final do numero

mov bx,[HANDLER] ; coloca manipulador do arquivo em bx
mov ah,3Eh 		; função 3Eh - fechar um arquivo
int 21h 		; chama serviço do DOS

; mov cx,2		; comprimento da string
; mov si,BUFFER 	; DS:SI - endereço da string
; xor bh,bh 		; página de vídeo - 0
; mov ah,0Eh 		; função 0Eh - escrever caracter

; NextChar:
;
; lodsb 			; AL = próximo caracter da string
; int 10h 		; chama serviço da BIOS
; loop NextChar

mov dx, PIXEL
mov ah,9
int 21h

mov ax,4C00h 		; termina programa
int 21h

mov ah,4ch
int 21h

segment data
CR equ 0dh
LF equ 0ah
HANDLER dw 0
BUFFER db 0,'$'
PIXEL db 0,0,0,'$'
ARQUIVO db 'teste.txt',0


segment stack stack
resb 256
stacktop:
