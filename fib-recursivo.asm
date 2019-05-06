#Fibonacci Recursivo
j Main
# a0 = parametro n
Fib:	li $t1, 1
	beqz $a0, Fib0
	beq $a0, $t1, Fib1
	j Fibn
	Fib0:	li $v0, 0
		jr $ra
	Fib1:	li $v0, 1
		jr $ra
	Fibn:	addi $sp, $sp, -8 # preparar para fib(n - 1)
		sw $a0, 4($sp)
		sw $ra, 0($sp)
		addi $a0, $a0, -1
		jal Fib # chamada para fib(n - 1)
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		addi $sp, $sp, 8
		
		addi $sp, $sp, -12 #preparar para fib(n - 2)
		sw $a0, 8($sp)
		sw $v0, 4($sp)
		sw $ra, 0($sp)
		addi $a0, $a0, -2
		jal Fib #chamada para fib(n - 2)
		lw $ra, 0($sp)
		lw $t0, 4($sp) #carrega o q foi salvo do retorno anterior para $t0
		lw $a0, 8($sp)
		addi $sp, $sp, 12
		
		add $v0, $t0, $v0
		jr $ra #retorna o resultado

Main:	li $a0, 3 # alguns testes da função
	jal Fib
	move $s0, $v0
	li $a0, 4
	jal Fib
	move $s1, $v0
	li $a0, 5
	jal Fib
	move $s2, $v0
	li $a0, 6
	jal Fib
	move $s3, $v0
