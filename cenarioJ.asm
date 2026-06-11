# TOTAL DE PIXELS: 128 colunas * 64 linhas = 8192 pixels
# LARGURA DA TELA: 128 pixels * 4 bytes = 512 bytes por linha
# +4 ? próximo pixel horizontal
# +512 ? próxima linha
# $25 ? endereço inicial
# $13 ? tamanho/altura

.text
main:	
	#endereço base
	lui $5, 0x1001
	lui $8, 0x1001
	lui $7, 0x1001
	li $10, 32256
	
	#cores
	li $9, 0xEF0004 	#paredes do labirinto (VERMELHO)
	li $19, 0xffff00	# PAC-MAN (Amarelo)
	li $20, 0xFFFFFF
	li $21 0x000000
	
for:  	beq $10, $0, nome
      	sw $20, 0($8)
     	addi $8, $8, 4
      	addi $10, $10, -1
      	j for
      
nome:
	j nomes
tempo:
	jal timer
	
	li $10, 32256
	# pinta de preto
for1: 	beq $10, $0, cenario
      	sw $21, 0($7)
      	addi $7, $7, 4
      	addi $10, $10, -1
      	j for1
      	
cenario: #testes pacman
	addi $25, $5, 0x38f8	# endereço. Linha 28, Pixel 62
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x5B68	
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x3D78	
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x3C7C
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x64A8
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x6CC4
	addi $13, $0, 6
	jal pacman
	
	addi $25, $5, 0x6548
	addi $13, $0, 6
	jal pacman
	
#====================================
	#BORDA DO CENARIO
	#laterais
	addi $25, $5, 0x000
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
	##CIMA
	#COLUNAS
	addi $25, $5, 0x0298
	addi $13, $0, 9
	jal coluna_dupla
	
	addi $25, $5, 0x0368
	addi $13, $0, 9
	jal coluna_dupla
	#LINHA
	addi $25, $5, 0x14C8
	addi $13, $0, 30
	jal linha_dupla
	#L ESQUERDA
	addi $25, $5, 0x182C
	addi $13, $0, 12
	jal coluna_dupla
	
	addi $25, $5, 0x162C
	addi $13, $0, 6
	jal linha_dupla
	#L DIREITA
	addi $25, $5, 0x19D0
	addi $13, $0, 12
	jal coluna_dupla
	
	addi $25, $5, 0x17C0
	addi $13, $0, 6
	jal linha_dupla
	
	
	##MEIO
	#ESQUERDA
	#LINHA CIMA
	addi $25, $5, 0x347C
	addi $13, $0, 9
	jal linha_dupla
	#LINHA BAIXO
	addi $25, $5, 0x4C7C
	addi $13, $0, 9
	jal linha_dupla
	
	#DIREITA
	#LINHA CIMA
	addi $25, $5, 0x3568
	addi $13, $0, 9
	jal linha_dupla
	#LINHA BAIXO
	addi $25, $5, 0x4D68
	addi $13, $0, 9
	jal linha_dupla
	
	#CAIXOTE
	addi $25, $5, 0x14C8
	addi $13, $0, 30
	jal linha_dupla
	
	addi $25, $5, 0x64C8
	addi $13, $0, 30
	jal linha_dupla
	
	addi $25, $5, 0x6B68
	addi $13, $0, 9
	jal duas_colunas
	
	
	##BAIXO
	#COLUNAS
	addi $25, $5, 0x6A98
	addi $13, $0, 9
	jal coluna_dupla
	
	addi $25, $5, 0x6B68
	addi $13, $0, 9
	jal coluna_dupla
	#LINHA
	addi $25, $5, 0x64C8
	addi $13, $0, 30
	jal linha_dupla
	
	
	#L DIREITA
	addi $25, $5, 0x53D0
	addi $13, $0, 12
	jal coluna_dupla
	
	addi $25, $5, 0x6BC0
	addi $13, $0, 6
	jal linha_dupla
	
	
	#L ESQUERDA
	addi $25, $5, 0x522C
	addi $13, $0, 12
	jal coluna_dupla
	
	addi $25, $5, 0x682C
	addi $13, $0, 6
	jal linha_dupla

		
	
	
	
	
	
	
	
	j fim
	
nomes:
	# J
	addi $25, $5, 0x324C
	addi $13, $0, 13
	jal coluna
	addi $25, $5, 0x3640
	addi $13, $0, 3
	jal coluna
	addi $25, $5, 0x3644
	addi $13, $0, 1
	jal linha
	addi $25, $5, 0x3648
	addi $13, $0, 1
	jal linha
	addi $25, $5, 0x4c44
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4640
	addi $13, $0, 3
	jal coluna
	
	# u
	addi $25, $5, 0x3E54
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3E60
	addi $13, $0, 8
	jal coluna
	addi $25, $5, 0x4C54
	addi $13, $0, 4
	jal linha

	# acento (ú)
	addi $25, $5, 0x385C
	addi $13, $0, 1
	jal linha
	addi $25, $5, 0x3660
	addi $13, $0, 1
	jal linha

	# l
	addi $25, $5, 0x326C
	addi $13, $0, 13
	jal coluna
	addi $25, $5, 0x4C6C
	addi $13, $0, 2
	jal linha

	# i
	addi $25, $5, 0x3E78
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3278
	addi $13, $0, 1
	jal linha
	addi $25, $5, 0x4C78
	addi $13, $0, 2
	jal linha

	# a (Júlia)
	addi $25, $5, 0x3E84
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3E90
	addi $13, $0, 8
	jal coluna
	addi $25, $5, 0x3A88
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4C84
	addi $13, $0, 5
	jal linha

#hadassa
	# H
	addi $25, $5, 0x32B0
	addi $13, $0, 13
	jal coluna
	addi $25, $5, 0x32CC
	addi $13, $0, 13
	jal coluna
	addi $25, $5, 0x46B4
	addi $13, $0, 6
	jal linha

	# a (Hadassa - 1º)
	addi $25, $5, 0x3ED8
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3EE4
	addi $13, $0, 8
	jal coluna
	addi $25, $5, 0x3ADC
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4CDC
	addi $13, $0, 4
	jal linha

	# d
	addi $25, $5, 0x3EF4
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x32FC
	addi $13, $0, 13
	jal coluna
	addi $25, $5, 0x3AF4
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4CF4
	addi $13, $0, 3
	jal linha

	# a (Hadassa - 2º)
	addi $25, $5, 0x3F0C
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3F18
	addi $13, $0, 8
	jal coluna
	addi $25, $5, 0x3B10
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4D10
	addi $13, $0, 4
	jal linha

	# s
	addi $25, $5, 0x3F24
	addi $13, $0, 4
	jal coluna
	addi $25, $5, 0x472C
	addi $13, $0, 4
	jal coluna
	addi $25, $5, 0x3B24
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4324
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4B24
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4D2C
	addi $13, $0, 2
	jal linha

	# s
	addi $25, $5, 0x3F38
	addi $13, $0, 4
	jal coluna
	addi $25, $5, 0x4740
	addi $13, $0, 4
	jal coluna
	addi $25, $5, 0x3B38
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4338
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4B38
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x4D40
	addi $13, $0, 2
	jal linha

	# a (Hadassa - 3º)
	addi $25, $5, 0x3F4C
	addi $13, $0, 7
	jal coluna
	addi $25, $5, 0x3F58
	addi $13, $0, 8
	jal coluna
	addi $25, $5, 0x3B50
	addi $13, $0, 2
	jal linha
	addi $25, $5, 0x4D50
	addi $13, $0, 4
	jal linha

	j tempo
	

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
	sw $19, 12($25)
	sw $19, 16($25)
	sw $19, 20($25)
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
	
coluna:
	beq $13, $0, retornar
	sw $9, 0($25)
	# sw $9, 4($25)
	addi $25, $25, 512 #pula linha
	addi $13, $13, -1
	j coluna

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

retornar:jr $31
timer:  addi $25, $0, 5000
fortim: beq $25, $0, fimtimer                  
        nop
        addi $25, $25, -1
        j fortim
fimtimer: jr $31