.data
	str:	.asciiz	"This is the text"
	chr:	.ascii		"x"

.text
main:
	la	$a0,str	# load string address in $a0 
	lb 	$a1,chr	# load chr in $a1 
	jal 	strrchr
	add 	$a0, $v0,$zero
	addi 	$v0,$zero,1
	syscall		# print counter
	addi 	$v0,$zero,10
	syscall		# terminate

strrchr:
	addi	$t0,$a0,0	# copy string address in $t0
	addi	$t1,$a1,0	# load char in $t1
	addi	$t3,$zero,1	# initialize position counter
	
cycle:
	lb	$t2,0($t0)	# load a char from string
	beq	$t2,$zero,end	# if T string = end
	beq	$t2,$t1,update	# update last char recurrence
cycle_:	
	addi	$t0,$t0,1	# move to the next char
	addi	$t3,$t3,1	# update position counter
	b	cycle

update:
	addi	$v0,$t3,0	# update last recurrence counter
	b	cycle_

end:
	beq	$v0,$zero,nochr # if T no char in string
	jr	$ra

nochr:
	addi	$v0,$zero,-1	# load -1 to print
	jr	$ra
		
