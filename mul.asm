# Multiplicação iterativa

# int mul(int a, int b) {
#	int p = 0;
#	while (b) {
#		if (b & 1)
#			p += a;
#		a <<= 1;
#		b >>= 1;
#	}
#	return p;
# }

j Main

Mul:	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $s0, $zero, 0
	MulWh:	beq $a1, $zero, Return
		andi $t0, $a1, 1
		beq $t0, $zero, MulFi
		add $s0, $s0, $a0
		MulFi:
		sll $a0, $a0, 1
		sra $a1, $a1, 1
		j MulWh
	Return:
	add $v0, $s0, $zero
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

Main:	addi $a0, $zero, 7
	addi $a1, $zero, 6
	jal Mul