# TOTAL DE PIXELS: 128 colunas * 64 linhas = 8192 pixels
# LARGURA DA TELA: 128 pixels * 4 bytes = 512 bytes por linha
# +4 ? próximo pixel horizontal
# +512 ? próxima linha

### Registradores de Configuração e Controle Geral

# $5: Guarda o endereço base do Bitmap Display (0x10010000)
# $7: Funcionando como o ponteiro de escrita para pintar a tela inteira de preto antes de começar o cenário
# $8: Limpa e pinta toda a tela de branco
# $10: É o contador de loops gerais

### Registradores do Sistema de Desenho (Argumentos das Funções)

# $9: Armazena a cor padrão das paredes do labirinto
# $13: É o contador de tamanho/comprimento
# $15: É o offset de distância usado exclusivamente pela função duascolunas.
# $19: Armazena a cor Amarela (do corpo do Pac-Man) 
# $20: Armazena a cor Branca
# $21: Armazena a cor Preta
# $22: É o registrador dinâmico de cor do fantasma (Rosa, Vermelho, Ciano, Laranja)
# $23: Armazena a cor Laranja
# $25: É o ponteiro de posição de desenho atual.

### Registradores da Função de Cópia de Cenário

# $11: Ponteiro de Leitura
# $12: Ponteiro de Escrita - backup na memória livre
# $24: Guarda a cor copiada

### Registradores Internos das Funções (Cálculos Auxiliares)

# $24: Além de ajudar na cópia, ele também é usado dentro da função duascolunas
# $31: Jal

###### Registradores livres: 6, 14, 16, $17, $18
###### Registradores que podem ser reutilizados: 8, 9, 10, 11, 12, 24



#################### precisa ajustar a altura das pontas

.text
main:	
	#endereço base
	lui $5, 0x1001
	lui $8, 0x1001
	lui $7, 0x1001
	li $10, 32256
	
	#cores
	li $9, 0xEF0004   #paredes do labirinto (VERMELHO)
	li $19, 0xffff00  # PACMAN (Amarelo)
	li $20, 0xFFFFFF  #branco
	li $21 0x000000   #preto
	li $23 0xFFA500   #laranja
	
for: 	beq $10, $0, nome
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
     	
cenario: 	
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
	
	addi $25, $5, 0x1838
	addi $13, $0, 12
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x162C
	addi $13, $0, 4
	jal linha
	
	addi $25, $5, 0x17C8
	addi $13, $0, 4
	jal linha
	
	
	
	
	addi $25, $5, 0x2E2C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x2FC8
	addi $13, $0, 3
	jal linha
	
	
	######MEIO
	#ESQUERDA
	#LINHA CIMA
	addi $25, $5, 0x2E6C
	addi $13, $0, 9
	jal linha
	addi $25, $5, 0x346C
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
	addi $25, $5, 0x4A6C
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x506C
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
	addi $25, $5, 0x2F78
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x3578
	addi $13, $0, 9
	jal linha
	
	#LINHA BAIXO
	addi $25, $5, 0x4B78
	addi $13, $0, 9
	jal linha
	
	addi $25, $5, 0x5178
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
	addi $25, $5, 0x6AC8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x64C8
	addi $13, $0, 30
	jal linha
	
	addi $25, $5, 0x66C8
	addi $13, $0, 3
	addi $15, $0, 116
	jal duascolunas
	
	
	
	
	
	#L 
	addi $25, $5, 0x522C
	addi $13, $0, 12
	addi $15, $0, 424
	jal duascolunas
	
	addi $25, $5, 0x5238
	addi $13, $0, 12
	addi $15, $0, 400
	jal duascolunas
	
	addi $25, $5, 0x522C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x53C8
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x682C
	addi $13, $0, 3
	jal linha
	
	addi $25, $5, 0x69CC
	addi $13, $0, 3
	jal linha
	
# ========================================
# CÓPIA DO CENÁRIO
# ========================================
copia_cenario:
	lui $11, 0x1001       # Ponteiro de LEITURA 0x10010000
	addi $12, $11, 32256  # Ponteiro de ESCRITA 0x10032256
	li $10, 8192          # Contador -> (128 colunas * 64 linhas)

loop_copia:
	beq $10, $0, pmf
	lw $24, 0($11)        # Lê a cor do pixel do cenário original e guarda em $24
	sw $24, 0($12)        # Escreve essa mesma cor na cópia reserva (área livre)
	
	addi $11, $11, 4
	addi $12, $12, 4
	addi $10, $10, -1     # Decrementa
	j loop_copia
	
pmf:	# pacman e fantasmas	
	
	li $22 0xFFC0CB        	#cor
	addi $25, $5, 0x34D0	#endereço que começa o fantasma
	jal fantasma
	
	
	li $22 0xFF0000
	addi $25, $5, 0x34EC	
	jal fantasma
	
	li $22 0x00FFFF
	addi $25, $5, 0x350C	
	jal fantasma
	
	li $22 0xFFA500
	addi $25, $5, 0x3528
	jal fantasma
	
	# Inicializa as posições oficiais dos fantasmas (endereço real na tela)
	addi $6, $5, 0x34D0	# Fantasma 1 (Rosa)
	addi $8, $5, 0x34EC	# Fantasma 2 (Vermelho)
	addi $14, $5, 0x350C	# Fantasma 3 (ciano)
	addi $15, $5, 0x3528	# Fantasma 4 (laranja)
	
	# Inicializa as direções iniciais de cada um (1=Cima, 2=Baixo, 3=Esquerda, 4=Direita)
	# todos começam indo pra cima
	li $11, 1		# Fantasma 1 
	li $12, 1		# Fantasma 2
	li $16, 1		# Fantasma 3
	li $10, 1		# Fantasma 4
	
	game_loop:
	# --- MOVIMENTAÇÃO DO FANTASMA 1 ---
	move $25, $6           # Passa a posição atual para a rotina
	move $17, $11           # Passa a direção atual
	li $22, 0xFFC0CB        # Cor Rosa
	jal atualizar_fantasma
	move $6, $25           # Salva a nova posição atualizada
	move $11, $24           # Salva a direção (que pode ter mudado se colidiu)

	# --- MOVIMENTAÇÃO DO FANTASMA 2 ---
	move $25, $8		# Passa a posição atual
	move $17, $12           # Passa a direção atual
	li $22, 0xFF0000        # Cor Vermelha
	jal atualizar_fantasma
	move $8, $25           # Salva a nova posição
	move $12, $24           # Salva a direção
	
	# --- MOVIMENTAÇÃO DO FANTASMA 3 ---
	move $25, $14           # Passa a posição atual
	move $17, $16           # Passa a direção atual
	li $22, 0x00FFFF        # Cor Ciano
	jal atualizar_fantasma
	move $14, $25           # Salva a nova posição
	move $16, $24           # Salva a direção
	
	# --- MOVIMENTAÇÃO DO FANTASMA 4 ---
	move $25, $15           # Passa a posição atual
	move $17, $10           # Passa a direção atual
	li $22, 0xFFA500        # Cor Laranja
	jal atualizar_fantasma
	move $15, $25           # Salva a nova posição
	move $10, $24           # Salva a direção

	# --- CONTROLE DE TEMPO (FRAME RATE) ---
	jal tim          # Espera um pouco para o olho humano conseguir acompanhar

	j game_loop             # Repete o ciclo infinitamente

	
	j fim
	
	
# ==============================================================================
# ROTINA GERAL DE ATUALIZAÇÃO DO FANTASMA (BORDAS REAIS + ANTICIPACAO DE 2PX)
# ==============================================================================
atualizar_fantasma:
	addi $sp, $sp, -4	
	sw $31, 0($sp)        # Salva o endereço de retorno

	# 1. APAGA O FANTASMA INTEGRALMENTE COM PRETO
	move $18, $22         # Salva a cor atual do fantasma em $18
	move $22, $21         # Altera temporariamente para a cor Preta ($21)
	jal fantasma          # Desenha o fantasma em preto (apaga tudo)
	move $22, $18         # Restaura a cor original do fantasma

	# 2. CALCULA PASSO REAL (1 PX) E PASSO DO SENSOR (2 PX À FRENTE)
	# $18 = Movimento suave real (1 pixel ou 1 linha)
	# $3  = Sensor de colisão (Olha 2 pixels ou 2 linhas à frente)
	# $2  = Canto/Extremidade Esquerda ou Superior de teste
	# $13 = Canto/Extremidade Direita ou Inferior de teste
	li $18, 0             
	beq $17, 1, cantos_cima
	beq $17, 2, cantos_baixo
	beq $17, 3, cantos_esq
	beq $17, 4, cantos_dir
	j t_colisao_ext

cantos_cima:  
	li $18, -512          # Passo real: 1 linha para cima
	li $3, -1024          # Sensor: 2 linhas para cima
	li $2, 0              # Canto esquerdo da cabeça (Pixel 0)
	li $13, 8             # Canto direito da cabeça (Pixel 8)
	j t_colisao_ext

cantos_baixo: 
	li $18, 512           # Passo real: 1 linha para baixo
	li $3, 1024           # Sensor: 2 linhas para baixo
	li $2, 2552           # Perninha mais à esquerda (Pixel 2552)
	li $13, 2576          # Perninha mais à direita (Pixel 2576)
	j t_colisao_ext

cantos_esq:   
	li $18, -4            # Passo real: 1 pixel para a esquerda
	li $3, -8             # Sensor: 2 pixels para a esquerda
	li $2, 508            # Borda lateral esquerda alta (Pixel 508)
	li $13, 2040          # Borda lateral esquerda baixa (Pixel 2040)
	j t_colisao_ext

cantos_dir:   
	li $18, 4             # Passo real: 1 pixel para a direita
	li $3, 8              # Sensor: 2 pixels para a direita
	li $2, 524            # Borda lateral direita alta (Pixel 524)
	li $13, 2064          # Borda lateral direita baixa (Pixel 2064)
	j t_colisao_ext

t_colisao_ext:
	# --- TESTE DA PRIMEIRA EXTREMIDADE NA CÓPIA DO CENÁRIO ---
	add $24, $25, $3      # Posição atual + Sensor antecipado
	add $24, $24, $2      # + Offset do primeiro canto real
	addi $24, $24, 32256  # Alinha com a CÓPIA DO CENÁRIO (0x10017e00)
	lw $2, 0($24)         # Lê a cor na cópia protegida
	beq $2, $9, colidiu_ext # Se bater na cor da parede ($9), para!

	# --- TESTE DA SEGUNDA EXTREMIDADE NA CÓPIA DO CENÁRIO ---
	add $24, $25, $3      # Posição atual + Sensor antecipado
	add $24, $24, $13     # + Offset do segundo canto real
	addi $24, $24, 32256  # Alinha com a CÓPIA DO CENÁRIO
	lw $2, 0($24)         # Lê a cor na cópia protegida
	beq $2, $9, colidiu_ext # Se o outro canto também bater, para!

	# 3. CAMINHO LIVRE: Avança 1 pixel suavemente
	add $25, $25, $18     # Atualiza a posição com o passo real de 1px
	move $24, $17         # Mantém a direção atual
	jal fantasma          # Desenha o fantasma na nova posição
	j fim_atualizacao_ext

colidiu_ext:
	# SE COLIDIR: Redesenha o fantasma exatamente onde ele estava
	jal fantasma          
	
sortear_nova_dir_ext:
	# Sorteador de direção (1 a 4)
	li $2, 42             
	li $4, 0              
	li $5, 4              
	syscall               
	addi $24, $4, 1       # Nova direção candidata em $24
	
	beq $24, $17, sortear_nova_dir_ext # Evita escolher a direção bloqueada
	
	lui $5, 0x1001        # Restaura o endereço base do display em $5

fim_atualizacao_ext:
	lw $31, 0($sp)
	addi $sp, $sp, 4
	jr $31

	
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
# time fantasma
tim: 	addi $25, $0, 10000
ft: 	beq $25, $0, fimt                  
        nop
        addi $25, $25, -1
        j ft
fimt: jr $31
timer: 	addi $25, $0, 10000
# time tela branca
fortim: beq $25, $0, fimtimer                  
        nop
        addi $25, $25, -1
        j fortim
fimtimer: jr $31