j Main
# Shell Sort
# void shellsort(int *v, int n) { // $a0, $a1
#	int aux;  // $s0
#	int i, j, h = 1; // $s1, $s2, $s3
#	while (h < n)
#		h = 3 * h + 1;
#	while (h > 1) {
#		h = h / 3;
#		for(i = h; i < n; i++) {
#			aux = v[i];
#			j = i - h;
#			while (j >= 0 && aux < v[j]) {
#				v[j + h] = v[j];
#				j -= h;
#			}
#			v[j + h] = aux;
#		}
#	}
#}
Shell:	addi $sp, $sp, -16 # salvar os valores dos registradores $s
	sw $s3, 12($sp)
	sw $s2,  8($sp)
	sw $s1,  4($sp)
	sw $s0,  0($sp)
	
	addi $s3, $zero, 1
	ShWh0:	slt $t0, $s3, $a1
		beq $t0, $zero, ShWh1
		addi $t0, $zero, 3
		mul $t0, $s3, $t0
		addi $s3, $t0, 1
		j ShWh0
	ShWh1:	addi $t0, $zero, 1
		slt $t0, $t0, $s3
		beq $t0, $zero, ShExit
		addi $t0, $zero, 3
		div $s3, $t0
		mflo $s3
		add $s1, $s3, $zero # i = h, começo do for
		ShFor:	slt $t0, $s1, $a1
			beq $t0, $zero, ShFEx
			sll $t0, $s1, 2 # preparar pra indexar o vetor
			add $t0, $a0, $t0
			lw $s0, 0($t0) # aux = v[i]
			sub $s2, $s1, $s3
			ShWh2:	slt $t0, $s2, $zero # se j < 0, sai do loop
				bne $t0, $zero, ShW2Ex
				sll $t0, $s2, 2
				add $t0, $a0, $t0 # $t0 = v + j 
				lw $t1, 0($t0) # $t1 = v[j]
				slt $t2, $s0, $t1
				beq $t2, $zero, ShW2Ex
				sll $t2, $s3, 2
				add $t0, $t0, $t2 # $t0 = v + j + h 
				sw $t1, 0($t0)
				sub $s2, $s2, $s3
				j ShWh2
			ShW2Ex:
			add $t0, $s2, $s3
			sll $t0, $t0, 2
			add $t0, $a0, $t0
			sw $s0, 0($t0)
			addi $s1, $s1, 1 # i++ do for
			j ShFor
		ShFEx:
		j ShWh1
	ShExit:
	lw $s0,  0($sp)
	lw $s1,  4($sp)
	lw $s2,  8($sp)
	lw $s3, 12($sp)
	addi $sp, $sp, 16 # voltar a pilha ao estado em que estava
	jr $ra # retornar a quem chamou a função

Main:	addi $a0, $zero, 0x00002000
	addi $a1, $zero, 8
	addi $s0, $zero, 10
	sw $s0, 0($a0)
	addi $s0, $zero, -5
	sw $s0, 4($a0)
	addi $s0, $zero, 2
	sw $s0, 8($a0)
	addi $s0, $zero, 3
	sw $s0, 12($a0)
	addi $s0, $zero, 8
	sw $s0, 16($a0)
	addi $s0, $zero, 4
	sw $s0, 20($a0)
	addi $s0, $zero, 1
	sw $s0, 24($a0)
	addi $s0, $zero, -7
	sw $s0, 28($a0)
	jal Shell