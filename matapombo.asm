
;tela tem 40em x por 30em y
;para printar em diferentes locais na tela deve-se calcular a posicao X*40Y (x que vc quiser e 40pulos na direcao y)
;para alterar a cor das palavras, deve-se somar 256 mais a palavra e printa-la

; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom						0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho					0100 0000
; 1280 roxo							0101 0000
; 1536 teal							0110 0000
; 1792 prata						0111 0000
; 2048 cinza						1000 0000
; 2304 vermelho						1001 0000
; 2560 lima							1010 0000
; 2816 amarelo						1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3840 branco						1111 0000


jmp main

;-----------------------------VARIAVEIS--------------------------;
frase_inicial: string "Precione uma tecla para comecar"
comeco: string ""

;vetor da posicao dos monstros na tela
monstro_pos: var #10				;inicializa todas as posicoes do monstro como o
static monstro_pos + #0, #0
static monstro_pos + #2, #0
static monstro_pos + #3, #0
static monstro_pos + #4, #0
static monstro_pos + #5, #0
static monstro_pos + #6, #0
static monstro_pos + #7, #0
static monstro_pos + #8, #0
static monstro_pos + #9, #0


;vetor da posicao dos tiros
tiros_pos: var #10
static tiro_pos + #0, #0		;inicializa todas as posicoes das balas como zero
static tiro_pos + #1, #0
static tiro_pos + #2, #0
static tiro_pos + #3, #0
static tiro_pos + #4, #0
static tiro_pos + #5, #0
static tiro_pos + #6, #0
static tiro_pos + #7, #0
static tiro_pos + #8, #0
static tiro_pos + #9, #0


frase_final: string "Fim de Jogo"
creditos: string "Concebido por Breno Pejon" ; Rodrigues??
escolha_final: string "Precione R para Recomecar ou S para sair"

limpar_tela0: string "                                         "	;40 espaços
limpar_tela: string "0000000000000000000000000000000000"	;40 espaços

base: string "    ^^^       ^^^       ^^^       ^^^   "
tiro1: string "     |                                  "
tiro2: string "               |                        "
tiro3: string "                         |              "
tiro4: string "                                   |    "

monstro1: string "     @                                  "
monstri2: string "               @                        "
monstro3: string "                         @              "
monstro4: string "                                   @    "

;------------------------------MAIN------------------------------;
main:
	call Menu			;chama o menu do jogo
	call Atirador		;chama o atirador para atirar em uma posicao
	call Bestas
	call Movimento
	call loop_do_jogo
	clearc

	call Imprime_base




	halt
	
	
	
	
	
	
	
	
	
	;call Limpar_tela	;NAO TA FUNCIONANDO
	
	
;-----------------------------FUNCOES--------------------------;	
	
Menu:
	push r0
	push r1
	push r2
	
	loadn r0, #frase_inicial ;carrega a mensagem
	loadn r1, #1120		 ;posicao na tela
	loadn r2, #512			 ;cor da letra
	
	call Impressao
	
	espera_jogador:			;espera resposta do jogador
	loadn r2, #255			;quando o usuario n digita nada ele pega o numero 255
	inchar r1  				;pega a resposta do usuario
	cmp r1, r2				;compara a resposta do usuario com 255
	jeq espera_jogador
	
	pop r2
	pop r1
	pop r0
	
	rts
	
	
Impressao:
	push r0				;r0 ->mensagem
	push r1				;r1 ->posicao da mensagem
	push r2				;r2 ->cor da mensagem
	push r3				;r3 ->'\0'
	push r4				;r4 ->auxiliar que armazena as letras a serem comparadas
	
	Impressao_Loop:	
	loadn r3, #'\0'		;compara final de frase
	loadi r4, r0		;r4 recebe letra pra comparar
	cmp r4, r3			;compara se chegou no final da frase
	jeq Imprime_final	;caso de saida do programa
	add r4, r4,r2		;soma a cor à letra
	outchar r4, r1		;printa na tela
	inc r0				;passa para proxima letra
	inc r1				;passa para proxima possicao na tela
	jmp Impressao_Loop
	
	
Imprime_final:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts
		
	
Limpar_tela:
	push r0
	push r1
	push r5					;r5-> r2 ja sera usado na impressao
	push r6
	
	loadn r0, #limpar_tela	;r0-> limpar tela( um monte de espacos)
	loadn r1, #0			;r1-> contador de linhas (40*n°da linha)
	loadn r5, #1200			;r5-> numero total de linhas (30*40)   
	loadn r6, #40			;r6-> registrador auxiliar para multiplicar por 40

	limpar_tela_loop:	
	call Impressao			;chama a funcao de impressao
	mul r1, r1, r6			;aumenta uma linha
	cmp r1, r5				;compara se chegou no final da tela
	jne limpar_tela_loop	;enquanto for diferente do final da tela, entrará no loop
	
	pop r6
	pop r5
	pop r1
	pop r0
	
	
	rts
	
Imprime_base:
	push r0		
	push r1
	push r2
	
	loadn r0, #base		;carrega a base
	loadn r1, #1120		;carrega posicao da base
	loadn r2, #256		;carrega cor da mensagem
	
	call Impressao		;imprime a base
	

	pop r2
	pop r1
	pop r0
	
	rts
	
;Funcao que chama o atirador
;nao tem argumentos
;saida em r0 a posicao do tiro
Atirador					
	push r1
	push r2
	push r3
	
	
	
	
	espera_jogador_tiro:	;espera resposta do jogador
	loadn r3, #50			;contador de tempo q esperará até atirar(tipo n ficar esperando toda a vida pra atirar)
	loadn r1, #0			;contador de vezes q passou pela funcao
	inc r1					;incrementa contador 
	loadn r2, #255			;quando o usuario n digita nada ele pega o numero 255
	inchar r3  				;pega a resposta do usuario
	cmp r0, r2				;compara a resposta do usuario com 255
	jeq espera_jogador_tiro	
	
	pop r3
	pop r2
	pop r1
	
	rts

;Funcao que movimenta as bestas e o tiro 
;argumentos r0-> local do tiro r1->local da besta

;saida - nenhuma
Movimento:
	
	loadn r2, #113		;carrega Q no r2 (eu acho)
	loadn r3, #119		;carrega W no r3
	loadn r4, #101		;carrega E no r4
	loadn r5, #114		;carrega R no r5
	
	;movimento do tiro
	cmp r0, r2			;verifica se foi Q
	jeq tiro_Q
	cmp r0, r3			;verifica se foi W
	jeq tiro_W
	cmp r0, r4			;verifica se foi E
	jeq tiro_E
	cmp r0, r5			;veridica se foi R
	jeq tiro_R
		
		

	
	