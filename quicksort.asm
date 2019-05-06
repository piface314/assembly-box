#qsort adaptado
j Main
Swap:	addi $sp,$sp,-4 #mover a pilha
	sw $s0,0($sp)
	sll $a1,$a1,2
	sll $a2,$a2,2
	add $t1,$a1,$a0 # t1: &a[i]
	add $t2,$a2,$a0 # t2: &a[j]
	lw $s0,0($t1) # $s0: aux, aux = a[i]
	lw $t0,0($t2) # $t0: a[j]
	sw $t0,0($t1) # a[i] = a[j]
	sw $s0,0($t2) # a[j] = aux
	lw $s0,0($sp)
	addi $sp,$sp,4
jr $ra

# $a0: *a , $a1: esq $a2: dir
# $s0: i, $s1: j, $s2: pivo
QuickSort: addi $sp,$sp,-16 #mover a pilha, savar s
	sw $ra,12($sp)
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)
	add $s0,$a1,$zero
	add $s1,$a2,$zero
	add $t0,$s0,$s1
	srl $t0,$t0,1
	sll $t0,$t0,2
	add $t0,$t0,$a0
	lw $s2,0($t0)
	sll $s0,$s0,2
	sll $s1,$s1,2
	qsdowh:	
		qswh1:	add $t0,$s0,$a0
			lw $t0,0($t0)
			slt $t0,$t0,$s2
			beq $t0,$zero,qswh2
			addi $s0,$s0,4
			j qswh1
		qswh2:	add $t0,$s1,$a0
			lw $t0,0($t0)
			slt $t0,$s2,$t0
			beq $t0,$zero,qswif
			addi $s1,$s1,-4
			j qswh2
		qswif:	slt $t0,$s1,$s0
			ori $at,$zero,1
			sub $t0,$at,$t0
			beq $zero,$t0,qswife
			addi $sp,$sp,-16
			sw $s1,12($sp)
			sw $s0,8($sp)
			sw $a2,4($sp)
			sw $a1,0($sp)
			srl $a1,$s0,2
			srl $a2,$s1,2
			jal Swap  # trocar a[i] e a[j]
			lw $a1,0($sp)
			lw $a2,4($sp)
			lw $s0,8($sp)
			lw $s1,12($sp)
			addi $sp,$sp,16
			addi $s0,$s0,4  #i++
			addi $s1,$s1,-4 #j--
	qswife:	slt $t0,$s1,$s0
	ori $at,$zero,1
	sub $t0,$at,$t0
	bne $t0,$zero,qsdowh
	sra $s0,$s0,2
	sra $s1,$s1,2
	slt $t0,$a1,$s1
	beq $t0,$zero,qsif1e
		addi $sp,$sp,-8
		sw $a2,4($sp)
		sw $a1,0($sp)
		add $a2,$zero,$s1
		jal QuickSort #(a,esq,j)
		lw $a1,0($sp)
		lw $a2,4($sp)
		addi $sp,$sp,8
	qsif1e:
	
	slt $t0,$s0,$a2
	beq $t0,$zero,qsif2e
		addi $sp,$sp,-8
		sw $a2,4($sp)
		sw $a1,0($sp)
		add $a1,$zero,$s0
		jal QuickSort #(a,i,dir)
		lw $a1,0($sp)
		lw $a2,4($sp)
		addi $sp,$sp,8
	qsif2e:	
	
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $ra,12($sp)
	addi $sp,$sp,16 #reajustar a fila
jr $ra


Main: addi $s7,$zero,0x0002000 # colocar aqui valor de endereço base da memória
addi $s0,$zero,-6
sw $s0,0($s7)
addi $s0,$zero,-3
sw $s0,4($s7)
addi $s0,$zero,2
sw $s0,8($s7)
addi $s0,$zero,0
sw $s0,12($s7)
addi $s0,$zero,7
sw $s0,16($s7)
addi $s0,$zero,15
sw $s0,20($s7)
addi $s0,$zero,8
sw $s0,24($s7)
addi $s0,$zero,10
sw $s0,28($s7)

add $a0,$zero,$s7
addi $a1,$zero,0
addi $a2,$zero,7
jal QuickSort
