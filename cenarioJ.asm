# TOTAL DE PIXELS: 128 colunas * 64 linhas = 8192 pixels
# LARGURA DA TELA: 128 pixels * 4 bytes = 512 bytes por linha
# +4 → próximo pixel horizontal
# +512 → próxima linha
# $25 → endereço inicial
# $13 → tamanho/altura

.text
main:	
	#endereço base
	lui $5, 0x1001
		
	#cores
	li $9, 0xEF0004 	#paredes do labirinto (VERMELHO)
	li $19, 0xffff00	# PAC-MAN (Amarelo)

cenario:
	#testes pacman
	addi $25, $5, 0x38f8	# endereço. Linha 28, Pixel 62
	addi $13, $0, 3
	jal pacman
	
	addi $25, $5, 0x387C	# endereço. Linha 28, Pixel 31
	addi $13, $0, 3
	jal pacman
	
	addi $25, $5, 0x4974	# endereço. Linha 36, Pixel 93
	addi $13, $0, 3
	jal pacman
	
	addi $25, $5, 0x3E40	# endereço. Linha 31, Pixel 16
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x4C40	# endereço. Linha 38, Pixel 16
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x5A40	# endereço. Linha 45, Pixel 16
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x68F8	# endereço. Linha 52, Pixel 62
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x5A9C	# endereço. Linha 45, Pixel 39
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x6840	# endereço. Linha 52, Pixel 16
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x2784	# endereço. Linha 19, Pixel 97
	addi $13, $0, 3
	jal pacman
	addi $25, $5, 0x27D0	# endereço. Linha 19, Pixel 116
	addi $13, $0, 3
	jal pacman
	
	
#====================================
	#BORDA DO CENARIO
	#laterais
	addi $25, $5, 0x0000
	addi $13, $0, 127
	addi $15, $0, 504
	jal duascolunas
	#cima
	addi $25, $5, 0x0000 
	addi $13, $0, 128
	jal linha_dupla
	#baixo
	addi $25, $5, 0x7C00 
	addi $13, $0, 128
	jal linha_dupla
#================================
	#CAIXOTE CIMA
	# p1 linha superior
	# linha 7 coluna 22
	addi $25, $5, 0xE98
	addi $13, $0, 23
	jal linha_dupla
	
	# p2 linha superior
	# linha 7 coluna 66
	addi $25, $5, 0xF08 
	addi $13, $0, 23
	jal linha_dupla
	
	# p1 linha inferior
	# linha 21 coluna 22
	addi $25, $5, 0x2A98
	addi $13, $0, 23
	jal linha_dupla
	
	# p2 linha inferior
	# linha 21 coluna 66
	addi $25, $5, 0x2B08
	addi $13, $0, 23
	jal linha_dupla
	
	#colunas
	addi $25, $5, 0xE98
	addi $13, $0, 14
	addi $15, $0, 196
	jal duascolunas
	
	#linha do meio
	# linha 14 coluna 30
	addi $25, $5, 0x1CB8	
	addi $13, $0, 36
	jal linha_dupla
#================================
	#CAIXOTE MEIO
	# p1 linha superior
	# linha 28 coluna 36
	addi $25, $5, 0x3890
	addi $13, $0, 25
	jal linha_dupla
	
	# p2 linha superior
	# linha 28 coluna 58
	addi $25, $5, 0x3908
	addi $13, $0, 25
	jal linha_dupla
	
	# linha inferior
	# linha 41 coluna 36
	addi $25, $5, 0x548C
	addi $13, $0, 57
	jal linha_dupla
	
	#colunas
	addi $25, $5, 0x388C
	addi $13, $0, 15
	addi $15, $0, 220
	jal duascolunas
#================================
	#C
	#CIMA ESQUERDA
	addi $25, $5, 0x3840
	addi $13, $0, 14
	jal linha_dupla
	
	addi $25, $5, 0x3870
	addi $13, $0, 14
	jal coluna_dupla
	
	addi $25, $5, 0x5440
	addi $13, $0, 14
	jal linha_dupla
	#BAIXO ESQUERDA
	addi $25, $5, 0x4620
	addi $13, $0, 14
	jal linha_dupla
	
	addi $25, $5, 0x4820
	addi $13, $0, 14
	jal coluna_dupla
	
	addi $25, $5, 0x6220
	addi $13, $0, 14
	jal linha_dupla
	
	#CIMA DIREITA
	addi $25, $5, 0x39A4
	addi $13, $0, 14
	jal linha_dupla
	
	addi $25, $5, 0x39D4
	addi $13, $0, 14
	jal coluna_dupla
	
	addi $25, $5, 0x55A4
	addi $13, $0, 14
	jal linha_dupla
	
	#BAIXO DIREITA
	addi $25, $5, 0x4784
	addi $13, $0, 14
	jal linha_dupla
	
	addi $25, $5, 0x4784
	addi $13, $0, 14
	jal coluna_dupla
	
	addi $25, $5, 0x6384
	addi $13, $0, 14
	jal linha_dupla
#================================
	#BAIXO MEIO
	#Colunas lados
	addi $25, $5, 0x6EB0
	addi $13, $0, 8 #altura
	addi $15, $0, 152 #largura
	jal duascolunas
	
	#C esquerda
	addi $25, $5, 0x6290
	addi $13, $0, 18
	jal linha_dupla
	
	addi $25, $5, 0x6290
	addi $13, $0, 8 #altura
	addi $15, $0, 72#largura
	jal coluna_dupla
	
	addi $25, $5, 0x62D0
	addi $13, $0, 8 #altura
	addi $15, $0, 72#largura
	jal coluna_dupla
	
	#Coluna meio
	addi $25, $5, 0x56F8
	addi $13, $0, 8
	jal coluna_dupla
	addi $25, $5, 0x70F8
	addi $13, $0, 6
	jal coluna_dupla
	
	#C direita
	addi $25, $5, 0x6328
	addi $13, $0, 18
	jal linha_dupla
	
	addi $25, $5, 0x6328
	addi $13, $0, 8 #altura
	addi $15, $0, 72#largura
	jal coluna_dupla
	
	addi $25, $5, 0x6368
	addi $13, $0, 8 #altura
	addi $15, $0, 72#largura
	jal coluna_dupla
	
	#BAIXO LATERAIS
	#ESQ
	addi $25, $5, 0x7038
	addi $13, $0, 6
	jal coluna_dupla
	
	addi $25, $5, 0x7060
	addi $13, $0, 14
	jal linha_dupla
	#DIR
	addi $25, $5, 0x7168
	addi $13, $0, 14
	jal linha_dupla
	
	addi $25, $5, 0x71C0
	addi $13, $0, 6
	jal coluna_dupla
	
	#TRIANGULO VAZADO
	#ESQ
	addi $25, $5, 0x13A0
	addi $13, $0, 10 #altura
	jal d_esq
	addi $25, $5, 0x13BC
	addi $13, $0, 10 #altura
	jal d_dir
	addi $25, $5, 0x2D94
	addi $13, $0, 14
	jal linha
	
	#DIR
	addi $25, $5, 0x1240
	addi $13, $0, 10 #altura
	jal d_esq
	addi $25, $5, 0x125C
	addi $13, $0, 10 #altura
	jal d_dir
	addi $25, $5, 0x2C34
	addi $13, $0, 14
	jal linha
	
	
	
	
	j fim
	
fim:
	addi $2, $0, 10
	syscall
	
	
# FUNÇÕES
# ==============================================================================

# Desenha o bloco amarelo de teste do Pac-Man
pacman:
	beq $13, $0, retornar
	sw $19, 0($25)
	sw $19, 4($25)
	sw $19, 8($25)
	addi $25, $25, 512	# próxima linha
	addi $13, $13, -1
	j pacman

coluna_dupla:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 4($25)
	addi $25, $25, 512 #pula linha
	addi $13, $13, -1
	j coluna_dupla

linha:
	beq $13, $0, retornar
	sw $9, 0($25)
	addi $25, $25, 4 #pula pixel
	addi $13, $13, -1
	j linha
	
linha_dupla:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 512($25)
	addi $25, $25, 4 #pula pixel
	addi $13, $13, -1
	j linha_dupla

duascolunas:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 4($25)
	add $24, $25, $15
	sw $9, 0($24)
	sw $9, 4($24)
	addi $25, $25, 512
	addi $13, $13, -1
	j duascolunas
#diagonal esquerda
d_esq:
	beq $13, $0, retornar
	sw $9, 0($25)
	#sw $9, 4($25)
	addi $25, $25, 508   # 512 - 4
	addi $13, $13, -1
	j d_esq
#diagonal direita
d_dir:
	beq $13, $0, retornar
	sw $9, 0($25)
	#sw $9, 4($25)
	addi $25, $25, 516   # 512 + 4
	addi $13, $13, -1
	j d_dir

retornar:	
	jr $31