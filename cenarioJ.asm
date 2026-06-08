# TOTAL DE PIXELS: 128 colunas * 64 linhas = 8192 pixels
# LARGURA DA TELA: 128 pixels * 4 bytes = 512 bytes por linha

.text
main:	
	#endereços base
	lui $5, 0x1001
	lui $6, 0x1001
	lui $8, 0x1001
	lui $7, 0x1001
	addi $7, $7, 0x7C00	# Início da última linha
		
	#cores
	li $9, 0xfa5a9a		# paredes do labirinto (Rosa)
	li $19, 0xffff00	# PAC-MAN (Amarelo)
	
	#contadores a partir do endereço
	addi $10, $0, 0x100	
	addi $11, $0, 0x1F00	
	addi $12, $0, 0x3F	

desenhar_borda_superior:
	beq $10, $0, desenhar_borda_inferior
	sw $9, 0($8)
	addi $8, $8, 4		
	addi $10, $10, -1	
	j desenhar_borda_superior
	
desenhar_borda_inferior:
	beq $11, 0x2000, desenhar_bordas_laterais 
	sw $9, 0($7)
	addi $7, $7, 4		
	addi $11, $11, 1	
	j desenhar_borda_inferior
	
desenhar_bordas_laterais:	
	beq $12, $0 , cenario
	sw $9, 0($6)		
	addi $6, $6, 4
	sw $9, 0($6)		
	addi $6, $6, 500	
	sw $9, 0($6)		
	addi $6, $6, 4		
	sw $9, 0($6)		
	addi $6, $6, 4		
	addi $12, $12, -1	
	j desenhar_bordas_laterais

cenario:
	#testes pacman
	addi $25, $5, 0x38f8	# endereço. Linha 28, Pixel 62
	addi $13, $0, 3
	jal desenhar_pacman
	
	addi $25, $5, 0x3880	# endereço. Linha 28, Pixel 32
	addi $13, $0, 3
	jal desenhar_pacman
	
	addi $25, $5, 0x3974	# endereço. Linha 28, Pixel 93
	addi $13, $0, 3
	jal desenhar_pacman
	
	addi $25, $5, 0x55d4	# endereço. Linha 42, Pixel 117
	addi $13, $0, 3
	jal desenhar_pacman
	
	#====================================
	#olhos da meia cara
	# linha 7 coluna 8
	# 7*512 + 8*4 = 3616 = 0xE20
	addi $25, $5, 0xE20	
	addi $13, $0, 9		# Altura
	addi $15, $0, 436	# Largura interna
	jal desenhar_2colunas
	
	#lateral da meia cara
	# linha 7 coluna 15
	# 7*512 + 15*4 = 3644 = 0xE3C
	addi $25, $5, 0xE3C	
	addi $13, $0, 14
	addi $15, $0, 380
	jal desenhar_2colunas
	
	#baixo da meia cara esquerda
	# linha 21 coluna 8
	# 21*512 + 8*4 = 10784 = 0x2A20
	addi $25, $5, 0x2A20
	addi $13, $0, 9
	jal desenhar_linha_dupla
	
	#baixo da meia cara direita
	# linha 21 coluna 110
	# 21*512 + 110*4 = 11192 = 0x2BB8
	addi $25, $5, 0x2BB8
	addi $13, $0, 9
	jal desenhar_linha_dupla
	
	#CAIXOTE CIMA
	# p1 linha superior
	# linha 7 coluna 22
	addi $25, $5, 0xE58
	addi $13, $0, 39
	jal desenhar_linha_dupla
	
	# p2 linha superior
	# linha 7 coluna 22
	addi $25, $5, 0xF08
	addi $13, $0, 38
	jal desenhar_linha_dupla
	
	# p1 linha inferior
	# linha 7 coluna 22
	addi $25, $5, 0x2A58
	addi $13, $0, 39
	jal desenhar_linha_dupla
	
	# p2 linha inferior
	# linha 7 coluna 22
	addi $25, $5, 0x2B08
	addi $13, $0, 38
	jal desenhar_linha_dupla
	
	#colunas
	addi $25, $5, 0xE58
	addi $13, $0, 14
	addi $15, $0, 320
	jal desenhar_2colunas
	
	#linha do meio
	addi $25, $5, 0x1C78	
	addi $13, $0, 66
	jal desenhar_linha_dupla
	
	#CAIXOTE MEIO
	# p1 linha superior
	# linha 7 coluna 22
	addi $25, $5, 0x3890
	addi $13, $0, 25
	jal desenhar_linha_dupla
	
	# p2 linha superior
	# linha 7 coluna 22
	addi $25, $5, 0x3908
	addi $13, $0, 25
	jal desenhar_linha_dupla
	
	# linha inferior
	# linha 7 coluna 22
	addi $25, $5, 0x5290
	addi $13, $0, 56
	jal desenhar_linha_dupla
	
	#colunas
	addi $25, $5, 0x3890
	addi $13, $0, 14
	addi $15, $0, 216
	jal desenhar_2colunas
	
	#SORRISOS
	#laterias esq
	addi $25, $5, 0x3820	
	addi $13, $0, 13	
	addi $15, $0, 80	
	jal desenhar_2colunas
	#laterias dir
	addi $25, $5, 0x3984	
	addi $13, $0, 13	
	addi $15, $0, 80	
	jal desenhar_2colunas
	#inferior esq
	addi $25, $5, 0x4E20	
	addi $13, $0, 20	
	jal desenhar_linha_dupla
	#inferior dir
	addi $25, $5, 0x4F84	
	addi $13, $0, 20	
	jal desenhar_linha_dupla
	#olhos esq
	addi $25, $5, 0x383C	
	addi $13, $0, 6		
	addi $15, $0, 24	
	jal desenhar_2colunas
	#olhos dir
	addi $25, $5, 0x39A0	
	addi $13, $0, 6		
	addi $15, $0, 24	
	jal desenhar_2colunas
	
	#H
	addi $25, $5, 0x5D84	
	addi $13, $0, 22
	jal desenhar_linha_dupla
	
	addi $25, $5, 0x6F84	
	addi $13, $0, 22	
	jal desenhar_linha_dupla
	
	addi $25, $5, 0x5C20
	addi $13, $0, 11 #altura
	addi $15, $0, 396 #largura
	jal desenhar_2colunas	
	#j
	addi $25, $5, 0x6420	
	addi $13, $0, 22
	jal desenhar_linha_dupla
	
	addi $25, $5, 0x6470
	addi $13, $0, 6
	jal desenhar_coluna_dupla
	
	addi $25, $5, 0x6E60
	addi $13, $0, 6
	jal desenhar_linha_dupla
	
	j fim
	
fim:
	addi $2, $0, 10
	syscall
	
	
# FUNÇÕES
# ==============================================================================

# Desenha o bloco amarelo de teste do Pac-Man
desenhar_pacman:
	beq $13, $0, retornar
	sw $19, 0($25)
	sw $19, 4($25)
	sw $19, 8($25)
	addi $25, $25, 512	# próxima linha
	addi $13, $13, -1
	j desenhar_pacman

desenhar_coluna_dupla:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 4($25)
	addi $25, $25, 512 #pula linha
	addi $13, $13, -1
	j desenhar_coluna_dupla

desenhar_linha_dupla:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 512($25)
	addi $25, $25, 4 #pula pixel
	addi $13, $13, -1
	j desenhar_linha_dupla

desenhar_2colunas:
	beq $13, $0, retornar
	sw $9, 0($25)
	sw $9, 4($25)
	add $24, $25, $15
	sw $9, 0($24)
	sw $9, 4($24)
	addi $25, $25, 512
	addi $13, $13, -1
	j desenhar_2colunas

retornar:	
	jr $31

	
