# Código: 
# 	int i, vetor[10]; for (i = 0; i < 10; i++) vetor[i] = i;
# i     => $s0
# vetor => $s1

addi $s1, $zero, 0x00002000	# alocando o endereço base do vetor
addi $s0, $zero, 0		# iniciando o for
For:	slti $t0, $s0, 10
	beq $t0, $zero, Exit
	sll $t0, $s0, 2		# sll = multiplicar por 2^n, para endereçar a memória por palavra
	add $t0, $t0, $s1
	sw $s0, 0($t0)		
	addi $s0, $s0, 1	# i++
	j For
Exit: nop