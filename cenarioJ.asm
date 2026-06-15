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
	li $9, 0xEF0004   #paredes do labirinto (VERMELHO)
	li $19, 0xffff00  # PAC-MAN (Amarelo)
	li $20, 0xFFFFFF  #branco
	li $21 0x000000   #preto
	li $23 0xFFA500   #laranja
	
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
	li $22 0xFFC0CB		#cor
	addi $25, $5, 0x20f8	#endereço que começa o fantasma
	jal fantasma
	
	addi $25, $5, 0x20D0
	jal pacman
	
	li $22 0xFFC0CB	       	
	addi $25, $5, 0x34D0	
	jal fantasma
	
	li $22 0xFF0000
	addi $25, $5, 0x34F0	
	jal fantasma
	
	li $22 0x00FFFF
	addi $25, $5, 0x350C	
	jal fantasma
	
	li $22 0xFFA500
	addi $25, $5, 0x3528
	jal fantasma
	
	addi $25, $5, 0x5B68	
	jal pacman
	
	addi $25, $5, 0x3D78	
	jal pacman
	
	addi $25, $5, 0x3C7C
	jal pacman
	
	addi $25, $5, 0x64A8
	jal pacman
	
	addi $25, $5, 0x6CC4
	jal pacman
	
	addi $25, $5, 0x6548
	jal pacman
	
	addi $25, $5, 0x4FA8
	jal pacman
	
	addi $25, $5, 0x33C8
	jal pacman
	
	
#====================================
	#BORDA DO CENARIO
	#esquerda
	addi $25, $5, 0x000
	addi $13, $0, 127
	jal coluna_dupla
	#direita
	addi $25, $5, 0x01F8
	addi $13, $0, 127
	jal coluna_dupla
	#cima
	addi $25, $5, 0x0000 
	addi $13, $0, 128
	jal linha_dupla
	#baixo
	addi $25, $5, 0x7C00 
	addi $13, $0, 128
	jal linha_dupla
#================================
	######CIMA
	#COLUNAS
	addi $25, $5, 0x0298
	addi $13, $0, 9
	addi $15, $0, 208
	jal duascolunas
	
	addi $25, $5, 0x028c
	addi $13, $0, 9
	addi $15, $0, 232
	jal duascolunas
	
	addi $25, $5, 0x1290
	addi $13, $0, 3
	jal linha
	addi $25, $5, 0x136C
	addi $13, $0, 3
	jal linha
	
	#LINHA
	addi $25, $5, 0x14C8
	addi $13, $0, 30
	jal linha
	addi $25, $5, 0x1AC8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x14C8
	addi $13, $0, 3
	addi $15, $0, 116
	jal duascolunas
	
	
	#L 
	addi $25, $5, 0x182C
	addi $13, $0, 12
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x1E38
	addi $13, $0, 9
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x162C
	addi $13, $0, 8
	jal linha
	
	addi $25, $5, 0x17B8
	addi $13, $0, 8
	jal linha
	
	addi $25, $5, 0x1C38
	addi $13, $0, 5
	jal linha
	
	addi $25, $5, 0x1DB8
	addi $13, $0, 5
	jal linha
	
	addi $25, $5, 0x1848
	addi $13, $0, 3
	addi $15, $0, 368
	jal duascolunas
	
	addi $25, $5, 0x2E2C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x2FC8
	addi $13, $0, 3
	jal linha
	
	
	######MEIO
	#ESQUERDA
	#LINHA CIMA
	addi $25, $5, 0x306C
	addi $13, $0, 9
	jal linha
	addi $25, $5, 0x366C
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x306C
	addi $13, $0, 3
	addi $15, $0, 268
	jal duascolunas
	addi $25, $5, 0x308C
	addi $13, $0, 3
	addi $15, $0, 268
	jal duascolunas
	#LINHA BAIXO
	addi $25, $5, 0x4C6C
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x526C
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x4C6C
	addi $13, $0, 3
	addi $15, $0, 268
	jal duascolunas
	
	addi $25, $5, 0x4C8C
	addi $13, $0, 3
	addi $15, $0, 268
	jal duascolunas
	#DIREITA
	#LINHA CIMA
	addi $25, $5, 0x3178
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x3778
	addi $13, $0, 9
	jal linha
	
	#LINHA BAIXO
	addi $25, $5, 0x4D78
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x5378
	addi $13, $0, 9
	jal linha
	
	
	#CAIXOTE
	addi $25, $5, 0x42C8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x48b8
	addi $13, $0, 38
	jal linha
	
	addi $25, $5, 0x30B8
	addi $13, $0, 13
	addi $15, $0, 148
	jal duascolunas
	
	addi $25, $5, 0x30C4
	addi $13, $0, 10
	addi $15, $0, 124
	jal duascolunas
	
	addi $25, $5, 0x2EB8
	addi $13, $0, 4
	jal linha
	
	addi $25, $5, 0x2F40
	addi $13, $0, 4
	jal linha
	
	
	
	#######BAIXO
	#COLUNAS
	addi $25, $5, 0x6A9C
	addi $13, $0, 9
	addi $15, $0, 204
	jal duascolunas
	
	addi $25, $5, 0x6A90
	addi $13, $0, 9
	addi $15, $0, 228
	jal duascolunas
	
	addi $25, $5, 0x6A90
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x6B6C
	addi $13, $0, 3
	jal linha
	
	#LINHA
	addi $25, $5, 0x64C8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x5EC8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x5EC8
	addi $13, $0, 3
	addi $15, $0, 116
	jal duascolunas
	
	
	
	#L ESQUERDA
	addi $25, $5, 0x522C
	addi $13, $0, 12
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x682C
	addi $13, $0, 6
	jal linha
	#L DIREITA
	addi $25, $5, 0x6BC0
	addi $13, $0, 6
	jal linha
	
	#L 
	addi $25, $5, 0x522C
	addi $13, $0, 12
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x5238
	addi $13, $0, 9
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x682C
	addi $13, $0, 8
	jal linha
	
	addi $25, $5, 0x6BB8
	addi $13, $0, 8
	jal linha
	
	addi $25, $5, 0x6238
	addi $13, $0, 5
	jal linha
	
	addi $25, $5, 0x65B8
	addi $13, $0, 5
	jal linha
	
	addi $25, $5, 0x6448
	addi $13, $0, 3
	addi $15, $0, 368
	jal duascolunas
	
	addi $25, $5, 0x522C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x53C8
	addi $13, $0, 3
	jal linha
	
	
	

		
	
	
	
	
	
	
	
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
pacman:	# primeira linha
    	sw $23, 0($25)
    	sw $23, 4($25)
    	sw $23, 8($25)

   	# segunda linha
    	sw $23, 508($25)
    	sw $19, 512($25)
    	sw $19, 516($25)
    	sw $19, 520($25)
   	sw $23, 524($25)

    	# terceira linha
    	sw $23, 1016($25)
    	sw $19, 1020($25)
    	sw $19, 1024($25)
    	sw $19, 1028($25)
    	sw $19, 1032($25)
    	sw $19, 1036($25)
    	sw $23, 1040($25)

    	# quarta linha
    	sw $23, 1528($25)
    	sw $19, 1532($25)
    	sw $19, 1536($25)
    	sw $19, 1540($25)
    	sw $23, 1544($25)

    	# quinta linha
    	sw $23, 2040($25)
    	sw $19, 2044($25)
    	sw $19, 2048($25)
    	sw $19, 2052($25)
    	sw $19, 2056($25)
    	sw $19, 2060($25)
    	sw $23, 2064($25)

    	# sexta linha
    	sw $23, 2556($25)
    	sw $19, 2560($25)
    	sw $19, 2564($25)
    	sw $19, 2568($25)
    	sw $23, 2572($25)

    	# sétima linha
    	sw $23, 3072($25)
    	sw $23, 3076($25)
    	sw $23, 3080($25)

    	jr $31
	
fantasma:
    	# cor do corpo
    	sw $22, 0($25)
    	sw $22, 4($25)
    	sw $22, 8($25)

    	sw $22, 508($25)
    	sw $22, 512($25)
    	sw $22, 516($25)
    	sw $22, 520($25)
    	sw $22, 524($25)

   	 # olhos
	sw $22, 1016($25)

	sw $20, 1020($25)
	sw $21, 1024($25)    # pupila esquerda
	sw $22, 1028($25)
	sw $20, 1032($25)
	sw $21, 1036($25)    # pupila direita
	sw $22, 1040($25)

    	# linha seguinte
    	sw $22, 1528($25)
    	sw $22, 1532($25)
    	sw $22, 1536($25)
    	sw $22, 1540($25)
    	sw $22, 1544($25)
    	sw $22, 1548($25)
    	sw $22, 1552($25)

    	# base
    	sw $22, 2040($25)
    	sw $22, 2044($25)
    	sw $22, 2048($25)
    	sw $22, 2052($25)
    	sw $22, 2056($25)
    	sw $22, 2060($25)
    	sw $22, 2064($25)
	
    	# perninhas
    	sw $22, 2552($25)
    	sw $22, 2560($25)
    	sw $22, 2568($25)
    	sw $22, 2576($25)
    	jr $31
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
	add $24, $25, $15
	sw $9, 0($24)
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