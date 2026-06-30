.text
main:	
	#endereço base
	lui $5, 0x1001
	lui $8, 0x1001
	lui $7, 0x1001
	li $10, 32256
	
	#cores
	li $9, 0x0000FF  #paredes do labirinto (AZUL)
	li $19, 0xffff00  # PAC-MAN (Amarelo)
	li $20, 0xFFFFFF  #branco
	li $21 0x000000   #preto
	li $23 0xFFA500   #laranja
      	
cenario1: 
	
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
	
	#L 
	addi $25, $5, 0x162C
	addi $13, $0, 15
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x1E38
	addi $13, $0, 11
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x162C
	addi $13, $0, 10
	jal linha
	
	addi $25, $5, 0x17B0
	addi $13, $0, 10
	jal linha
	
	addi $25, $5, 0x1C38
	addi $13, $0, 7
	jal linha
	
	addi $25, $5, 0x1DB0
	addi $13, $0, 7
	jal linha
	
	addi $25, $5, 0x1850
	addi $13, $0, 3
	addi $15, $0, 352
	jal duascolunas
	
	addi $25, $5, 0x322C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x33C8
	addi $13, $0, 3
	jal linha
	
	
	######MEIO
	#OLHOS FORA
	#ESQUERDA
	#LINHA CIMA
	addi $25, $5, 0x2880
	addi $13, $0,15
	jal linha
	#LINHA BAIXO
	addi $25, $5, 0x4880
	addi $13, $0, 15
	jal linha
	addi $25, $5, 0x2880
	addi $13, $0, 16
	addi $15, $0, 264
	jal duascolunas
	addi $25, $5, 0x28B8
	addi $13, $0, 16
	addi $15, $0, 152
	jal duascolunas
	
	#DIREITA
	#LINHA CIMA
	addi $25, $5, 0x2950
	addi $13, $0, 15
	jal linha
	
	addi $25, $5, 0x4950
	addi $13, $0, 15
	jal linha
	
	#OLHOS DENTRO
	#ESQUERDA
	#LINHA CIMA
	addi $25, $5, 0x3160
	addi $13, $0, 7
	jal linha
	#LINHA BAIXO
	addi $25, $5, 0x3090
	addi $13, $0, 7
	jal linha
	addi $25, $5, 0x3160
	addi $13, $0, 8
	addi $15, $0, 24
	jal duascolunas
	addi $25, $5, 0x3090
	addi $13, $0, 8
	addi $15, $0, 24
	jal duascolunas
	
	#
	addi $25, $5, 0x4160
	addi $13, $0, 7
	jal linha
	
	addi $25, $5, 0x4090
	addi $13, $0, 7
	jal linha
	
	#DIREITA
	#LINHA CIMA
	addi $25, $5, 0x2950
	addi $13, $0, 15
	jal linha
	
	addi $25, $5, 0x4950
	addi $13, $0, 15
	jal linha
	
	
	
	
	
	#######BAIXO
	#COLUNAS
	addi $25, $5, 0x48FC
	addi $13, $0, 12
	addi $15, $0, 12
	jal duascolunas
	
	addi $25, $5, 0x48FC
	addi $13, $0, 3
	jal linha

	
	#LINHA
	addi $25, $5, 0x5EC8
	addi $13, $0, 13
	jal linha
	
	addi $25, $5, 0x5F0C
	addi $13, $0, 13
	jal linha
	
	addi $25, $5, 0x64C8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x5EC8
	addi $13, $0, 3
	addi $15, $0, 116
	jal duascolunas
	
	
	#L 
	addi $25, $5, 0x4E2C
	addi $13, $0, 14
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x4E38
	addi $13, $0, 11
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x682C
	addi $13, $0, 10
	jal linha
	
	addi $25, $5, 0x6BB0
	addi $13, $0, 10
	jal linha
	
	addi $25, $5, 0x6238
	addi $13, $0, 7
	jal linha
	
	addi $25, $5, 0x65B0
	addi $13, $0, 7
	jal linha
	
	addi $25, $5, 0x6450
	addi $13, $0, 3
	addi $15, $0, 352
	jal duascolunas
	
	addi $25, $5, 0x4E2C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x4FC8
	addi $13, $0, 3
	jal linha
	
li $20, 0xFFFFFF  #branco
	jal desenhar_migalhas
jr $31
	
	
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

migalha_horizontal:
    beq $13,$0,retornar

    sw $20,0($25)

    addi $25,$25,32   # distância de 8 pixels entre migalhas
    addi $13,$13,-1
    j migalha_horizontal
   
migalha_vertical:
    beq $13,$0,retornar

    sw $20,0($25)

    addi $25,$25,4096   # 8 linhas (8×512)
    addi $13,$13,-1
    j migalha_vertical
    
    
###############
desenhar_migalhas:
#cima
addi $25,$5,0x0C20
li   $13,15
jal  migalha_horizontal

addi $25,$5,0x1C60
li   $13,11
jal  migalha_horizontal

addi $25,$5,0x1818
li   $13,6
jal  migalha_vertical

addi $25,$5,0x19E8
li   $13,6
jal  migalha_vertical

addi $25,$5,0x7420
li   $13,15
jal  migalha_horizontal



#

#meio
addi $25,$5,0x4038
li   $13,1
jal  migalha_horizontal

addi $25,$5,0x41C8
li   $13,1
jal  migalha_horizontal


addi $25,$5,0x3060
li   $13,4
jal  migalha_vertical

addi $25,$5,0x31A0
li   $13,4
jal  migalha_vertical


addi $25,$5,0x5088
li   $13,2
jal  migalha_horizontal

addi $25,$5,0x5158
li   $13,2
jal  migalha_horizontal


addi $25,$5,0x6088
li   $13,2
jal  migalha_horizontal

addi $25,$5,0x6158
li   $13,2
jal  migalha_horizontal


addi $25,$5,0x30D0
li   $13,3
jal  migalha_vertical

addi $25,$5,0x3130
li   $13,3
jal  migalha_vertical

addi $25,$5,0x30F0
li   $13,2
jal  migalha_horizontal

addi $25,$5,0x40F0
li   $13,2
jal  migalha_horizontal



retornar:jr $31



	
