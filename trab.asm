; TRABALHO DE PROGRAMACAO
; DISCIPLINA: SISTEMAS EMBARCADOS I
; ALUNO: LEONARDO SANTOS PAULUCIO
; TURMA: 06

segment code
..start:
mov ax,data
mov ds,ax
mov ax,stack
mov ss,ax
mov sp,stacktop

; salvar modo corrente de video(vendo como esta o modo de video da maquina)
mov ah,0Fh
int 10h
mov [modo_anterior],al

; alterar modo de video para gr?fico 640x480 16 cores
mov al,12h
mov ah,0
int 10h

call INTERFACE

call LE_ARQUIVO

call IMPRIME_IMG

mov ah,08h
int 21h
mov ah,0   			; set video mode
mov al,[modo_anterior]   	; modo anterior
int 10h
mov ah,4ch
int 21h

; ---------------------------- INTERFACE --------------------------------------
INTERFACE:
	;Desenhar Janela externa
	;limite esquerdo
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 0; x
	push ax
	mov	ax, 0 ; y
	push ax
	;segundo ponto
	mov	ax, 0 ; x
	push ax
	mov	ax, 479 ; y
	push ax
	call line

	;limite direito
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 639; x
	push ax
	mov	ax, 0 ; y
	push ax
	;segundo ponto
	mov	ax, 639 ; x
	push ax
	mov	ax, 479 ; y
	push ax
	call line

	;limite superior
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 0; x
	push ax
	mov	ax, 479 ; y
	push ax
	;segundo ponto
	mov	ax, 639 ; x
	push ax
	mov	ax, 479 ; y
	push ax
	call line

	;limite inferior
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 0; x
	push ax
	mov	ax, 0 ; y
	push ax
	;segundo ponto
	mov	ax, 639 ; x
	push ax
	mov	ax, 0 ; y
	push ax
	call line

	;caixa do nome
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 0; x
	push ax
	mov	ax, 130 ; y
	push ax
	;segundo ponto
	mov	ax, 250 ; x
	push ax
	mov	ax, 130 ; y
	push ax
	call line

	;caixa opcoes
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 0; x
	push ax
	mov	ax, 381 ; y
	push ax
	;segundo ponto
	mov	ax, 251 ; x
	push ax
	mov	ax, 381 ; y
	push ax
	call line

	;abrir
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 60; x
	push ax
	mov	ax, 479 ; y
	push ax
	;segundo ponto
	mov	ax, 60 ; x
	push ax
	mov	ax, 381 ; y
	push ax
	call line

	;sair
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 120; x
	push ax
	mov	ax, 480 ; y
	push ax
	;segundo ponto
	mov	ax, 120 ; x
	push ax
	mov	ax, 381 ; y
	push ax
	call line

	;histo
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 180; x
	push ax
	mov	ax, 479 ; y
	push ax
	;segundo ponto
	mov	ax, 180 ; x
	push ax
	mov	ax, 381 ; y
	push ax
	call line

	;histoe
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 251; x
	push ax
	mov	ax, 479 ; y
	push ax
	;segundo ponto
	mov	ax, 251 ; x
	push ax
	mov	ax, 0 ; y
	push ax
	call line

	;divisao histogramas
	mov	byte[cor],branco_intenso
	;primeiro ponto
	mov	ax, 251; x
	push ax
	mov	ax, 240 ; y
	push ax
	;segundo ponto
	mov	ax, 639 ; x
	push ax
	mov	ax, 240 ; y
	push ax
	call line

	;Informacoes
	;escrever uma mensagem

	;Nome
	mov cx,24			;numero de caracteres
	mov bx,0
	mov dh,23			;linha 0-29
	mov dl,3			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_nome:
	call	cursor
	mov al,[bx+NOME]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop    w_nome

	;Disciplina
	mov cx,21			;numero de caracteres
	mov bx,0
	mov dh,25			;linha 0-29
	mov dl,4			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_disc:
	call	cursor
	mov al,[bx+DISCIPLINA]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop    w_disc

	;Periodo
	mov cx,6			;numero de caracteres
	mov bx,0
	mov dh,27			;linha 0-29
	mov dl,10			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_periodo:
	call	cursor
	mov al,[bx+PERIODO]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop   w_periodo

	;Abrir
	mov cx,5			;numero de caracteres
	mov bx,0
	mov dh,3			;linha 0-29
	mov dl,1			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_abrir:
	call	cursor
	mov al,[bx+ABRIR]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop   w_abrir

	;Sair
	mov cx,4			;numero de caracteres
	mov bx,0
	mov dh,3			;linha 0-29
	mov dl,9			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_sair:
	call	cursor
	mov al,[bx+SAIR]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop   w_sair

	;Hist
	mov cx,4			;numero de caracteres
	mov bx,0
	mov dh,3		;linha 0-29
	mov dl,17			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_hist:
	call	cursor
	mov al,[bx+HIST]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop   w_hist

	;Histeq
	mov cx,6			;numero de caracteres
	mov bx,0
	mov dh,3			;linha 0-29
	mov dl,24			;coluna 0-79
	mov	byte[cor],branco_intenso
	w_histeq:
	call	cursor
	mov al,[bx+HISTEQ]
	call caracter
	inc bx			;proximo caracter
	inc	dl			;avanca a coluna
	loop   w_histeq

ret
; ---------------------------- FIM DA INTERFACE -------------------------------


; ---------------------------- LEITURA DE ARQUIVO -----------------------------

LE_ARQUIVO:
	mov dx, ARQUIVO 	; coloca o endereço do nome do arquivo em dx
	mov al,2 		; modo de acesso - leitura e escrita
	mov ah,3Dh 		; função 3Dh - abre um arquivo
	int 21h 		; chama serviço do DOS
	mov [HANDLER],ax 	; guarda o manipulador do arquivo para mais tarde

	mov cx, 62500
	mov si, DADOS

	LE_PIX: ;Le um pixel do arquivo
		push cx
		push si
		xor di,di
		xor si,si
		mov di, BUFFER
		mov si, PIXEL

		LEITURA:
			mov dx, di 		; endereço do buffer em dx
			mov bx,[HANDLER] 	; manipulador em bx
			mov cx,1 		; quantidade de bytes a serem lidos
			mov ah,3Fh 		; função 3Fh - leitura de arquivo
			int 21h 		; chama serviço do DOS
			cmp ax, 0
			je FIM_PIX2

			mov dl, byte[di] 	; move para dl o valor lido
			cmp dl, 20h      	; verifica se e espaco
			je FIM_PIX       	; se for espaco vai termina a leitura do pixel

			mov [si], dl     	; se nao entrar no jump salva leitura para ler o proximo
			add si, 1        	; incrementa o ponteiro para a proxima posicao
		jmp LEITURA

		FIM_PIX2:
			sub si, 1

		FIM_PIX:
			mov byte[si], 20h	; coloca espaco para indicar final do numero aki o valor ja se encontra em PIXEL

			xor cx,cx		; zera cx
			mov si, PIXEL		; endereco de pixel em SI

		VOLTA:
			mov al, byte[si]	; move pra ax o conteudo de SI
			cmp al, 20h		; verifica se e espaco
			je SAI			; se for acaba
			add si,1		; incrementa si e cx
			add cx,1
		jmp VOLTA

		SAI:
		xor bx, bx			; zera bx e di
		xor di, di
		mov bh, 1			; bh vai ter o valor a ser multiplicado na iteracao atual
		mov bl, 10			; bl vai ter o valor a ser multiplicado na proxima iteracao
		sub si, 1			; pega os algarismos de tras para frente

		A2B:
			mov dl, byte[si]	; dl recebe o algarismo
			sub dl, 30h		; converte para binario
			mov al, bh		; pega o valor a ser multiplicado
			mul dl			
			and ax, 00ffh		; pega so a parte baixa de ax
			add di, ax		; soma ao acumulador di
			mov bh, bl		; atualiza proximos valores que serao multiplicados
			mov al, bh
			mul bl
			mov bl, al
			sub si, 1		; aponta para o proximo algarismo
		loop A2B		; repete ate acabar

		pop si				; recupera si
		mov [si], di			; numero em binario em di
		add si, 1			; pega proximo dado
		pop cx				; recupera cx
	loop LE_PIX			; repete ate acabar os dados


	mov bx,[HANDLER] 	; coloca manipulador do arquivo em bx
	mov ah,3Eh 		; função 3Eh - fechar um arquivo
	int 21h 		; chama serviço do DOS

ret
;--------------------------------------------- FIM LEITURA ARQUIVO ---------------------------

IMPRIME_IMG:
	mov dx, 1  ;posx 
	mov ax, 380   ;posy
	xor si, si	
	mov cx, 250 ;n de colunas na horizontal
	imprime_l: ; varia y
		push cx
		push ax
		push dx
		mov cx, 250
		imprime_c: ;varia x
			push cx
			push ax
			push dx ;posx
			push ax	;posy
			mov al, byte[DADOS+si]
			and ax, 00FFh
			mov bh, 10h  ; 16 para dividir
			div bh
			mov byte[cor], al

			call plot_xy

			pop ax
			pop cx
			add si,1
			add dx, 1
		loop imprime_c
		pop dx
		pop ax
		sub ax,1
		pop cx
	loop imprime_l	
ret
	
; ----------------------------- HISTOGRAMA --------------------------------

HISTOGRAMA:
	




;***************************************************************************
;
;   fun??o cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
	pushf
	push 		ax
	push 		bx
	push		cx
	push		dx
	push		si
	push		di
	push		bp
	mov     	ah,2
	mov     	bh,0
	int     	10h
	pop		bp
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
ret
;_____________________________________________________________________________
;
;   fun??o caracter escrito na posi??o do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
	pushf
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	push	bp
	mov ah,9
	mov bh,0
	mov cx,1
	mov bl,[cor]
	int 10h
	pop		bp
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	ret
;_____________________________________________________________________________
;
;   fun??o plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
	push		bp
	mov		bp,sp
	pushf
	push 		ax
	push 		bx
	push		cx
	push		dx
	push		si
	push		di
	mov     	ah,0ch
	mov     	al,[cor]
	mov     	bh,0
	mov     	dx,479
	sub		dx,[bp+4]
	mov     	cx,[bp+6]
	int     	10h
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		4
;_____________________________________________________________________________
;    fun??o circle
;	 push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r

	mov 	dx,bx
	add		dx,cx       ;ponto extremo superior
	push    ax
	push	dx
	call plot_xy

	mov		dx,bx
	sub		dx,cx       ;ponto extremo inferior
	push    ax
	push	dx
	call plot_xy

	mov 	dx,ax
	add		dx,cx       ;ponto extremo direita
	push    dx
	push	bx
	call plot_xy

	mov		dx,ax
	sub		dx,cx       ;ponto extremo esquerda
	push    dx
	push	bx
	call plot_xy

	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser? a vari?vel x. cx ? a variavel y

	;aqui em cima a l?gica foi invertida, 1-r => r-1
	;e as compara??es passaram a ser jl => jg, assim garante
	;valores positivos para d

stay:				;loop
	mov		si,di
	cmp		si,0
	jg		inf       ;caso d for menor que 0, seleciona pixel superior (n?o  salta)
	mov		si,dx		;o jl ? importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)

plotar:
	mov		si,dx
	add		si,ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si,cx
	add		si,bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do s?timo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante

	cmp		cx,dx
	jb		fim_circle  ;se cx (y) est? abaixo de dx (x), termina
	jmp		stay		;se cx (y) est? acima de dx (x), continua no loop


fim_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;    fun??o full_circle
;	 push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
full_circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r

	mov		si,bx
	sub		si,cx
	push    ax			;coloca xc na pilha
	push	si			;coloca yc-r na pilha
	mov		si,bx
	add		si,cx
	push	ax		;coloca xc na pilha
	push	si		;coloca yc+r na pilha
	call line


	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser? a vari?vel x. cx ? a variavel y

;aqui em cima a l?gica foi invertida, 1-r => r-1
;e as compara??es passaram a ser jl => jg, assim garante
;valores positivos para d

stay_full:				;loop
	mov		si,di
	cmp		si,0
	jg		inf_full       ;caso d for menor que 0, seleciona pixel superior (n?o  salta)
	mov		si,dx		;o jl ? importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar_full
	inf_full:
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)

plotar_full:
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha
	call 	line

	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha
	call	line

	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha
	call	line

	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha
	call	line

	cmp		cx,dx
	jb		fim_full_circle  ;se cx (y) est? abaixo de dx (x), termina
	jmp		stay_full		;se cx (y) est? acima de dx (x), continua no loop


fim_full_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;
;   fun??o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
	push		bp
	mov		bp,sp
	pushf                        ;coloca os flags na pilha
	push 		ax
	push 		bx
	push		cx
	push		dx
	push		si
	push		di
	mov		ax,[bp+10]   ; resgata os valores das coordenadas
	mov		bx,[bp+8]    ; resgata os valores das coordenadas
	mov		cx,[bp+6]    ; resgata os valores das coordenadas
	mov		dx,[bp+4]    ; resgata os valores das coordenadas
	cmp		ax,cx
	je		line2
	jb		line1
	xchg		ax,cx
	xchg		bx,dx
	jmp		line1
	line2:		; deltax=0
	cmp		bx,dx  ;subtrai dx de bx
	jb		line3
	xchg		bx,dx        ;troca os valores de bx e dx entre eles
	line3:	; dx > bx
	push		ax
	push		bx
	call 		plot_xy
	cmp		bx,dx
	jne		line31
	jmp		fim_line
	line31:		inc		bx
	jmp		line3
	;deltax <>0
	line1:
; comparar m?dulos de deltax e deltay sabendo que cx>ax
; cx > ax
	push		cx
	sub		cx,ax
	mov		[deltax],cx
	pop		cx
	push		dx
	sub		dx,bx
	ja		line32
	neg		dx
	line32:
	mov		[deltay],dx
	pop		dx

	push		ax
	mov		ax,[deltax]
	cmp		ax,[deltay]
	pop		ax
	jb		line5

; cx > ax e deltax>deltay
	push		cx
	sub		cx,ax
	mov		[deltax],cx
	pop		cx
	push		dx
	sub		dx,bx
	mov		[deltay],dx
	pop		dx

	mov		si,ax
line4:
	push		ax
	push		dx
	push		si
	sub		si,ax	;(x-x1)
	mov		ax,[deltay]
	imul		si
	mov		si,[deltax]		;arredondar
	shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
	cmp		dx,0
	jl		ar1
	add		ax,si
	adc		dx,0
	jmp		arc1
ar1:
	sub		ax,si
	sbb		dx,0
arc1:
	idiv		word [deltax]
	add		ax,bx
	pop		si
	push		si
	push		ax
	call		plot_xy
	pop		dx
	pop		ax
	cmp		si,cx
	je		fim_line
	inc		si
	jmp		line4

	line5:		cmp		bx,dx
	jb 		line7
	xchg		ax,cx
	xchg		bx,dx
	line7:
	push		cx
	sub		cx,ax
	mov		[deltax],cx
	pop		cx
	push		dx
	sub		dx,bx
	mov		[deltay],dx
	pop		dx

	mov		si,bx
line6:
	push		dx
	push		si
	push		ax
	sub		si,bx	;(y-y1)
	mov		ax,[deltax]
	imul		si
	mov		si,[deltay]		;arredondar
	shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
	cmp		dx,0
	jl		ar2
	add		ax,si
	adc		dx,0
	jmp		arc2
ar2:
	sub		ax,si
	sbb		dx,0
arc2:
	idiv		word [deltay]
	mov		di,ax
	pop		ax
	add		di,ax
	pop		si
	push		di
	push		si
	call		plot_xy
	pop		dx
	cmp		si,dx
	je		fim_line
	inc		si
	jmp		line6

fim_line:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		8

;*******************************************************************

; ------------------------ SEGMENTO DE DADOS
segment data

cor db branco_intenso
;	I R G B COR
;	0 0 0 0 preto
;	0 0 0 1 azul
;	0 0 1 0 verde
;	0 0 1 1 cyan
;	0 1 0 0 vermelho
;	0 1 0 1 magenta
;	0 1 1 0 marrom
;	0 1 1 1 branco
;	1 0 0 0 cinza
;	1 0 0 1 azul claro
;	1 0 1 0 verde claro
;	1 0 1 1 cyan claro
;	1 1 0 0 rosa
;	1 1 0 1 magenta claro
;	1 1 1 0 amarelo
;	1 1 1 1 branco intenso

preto		equ		0
azul		equ		1
verde		equ		2
cyan		equ		3
vermelho	equ		4
magenta		equ		5
marrom		equ		6
branco		equ		7
cinza		equ		8
azul_claro	equ		9
verde_claro	equ		10
cyan_claro	equ		11
rosa		equ		12
magenta_claro	equ		13
amarelo		equ		14
branco_intenso	equ		15

modo_anterior	db		0
linha   	dw  		0
coluna  	dw  		0
deltax		dw		0
deltay		dw		0


CR equ 0dh
LF equ 0ah

NOME		db	'Leonardo Santos Paulucio' ;24 letras
DISCIPLINA	db	'Sistemas Embarcados I' ;21 letras
PERIODO		db	'2016/1';6 letras
ABRIR 		db 	'Abrir' ;5 letras
SAIR 		db	'Sair' ; 4 letras
HIST 		db	'Hist' ;4 letras
HISTEQ 		db 	'Histeq';6 letras

HANDLER 	dw 	0
BUFFER 		db 	0,20h,'$'
PIXEL 		db 	0,0,0,20h,'$'
ARQUIVO 	db 	'imagem.txt','$'
RESULTADO 	db 	0, '$'
N_PIX 		dw 	62500
DADOS 		resb 	62500
HISTOGRAMA	resw	255



;*************************************************************************
segment stack stack
resb	512
stacktop:
