#Identificar casos		
		addi s1,zero, -2
		addi s2,zero, 31
		
		addi s4,zero, 32
		bge s1,zero,A
		addi s3,s3,3
		
	A:	beq s2,s4,C #branch if equal
		blt s2,s4,B #NAO SEI PORQUE MAS BLE NAO FUNCIONA APENAS BLT #branch if less than
		bge s2,s4,D #branch if greater or equal
		
	B:	addi s3,s3,1
	C:	addi s3,s3,1
	D:	addi s3,s3,1		
	
#Reescreva   o   programa   inicial   (das   comparações   de   s1   e   s2)   utilizando  pelo menos uma
#instrução blez e pelo menos uma instrução beqz. Observe na aba Execute do RARS quais são
#as instruções nativas equivalentes que o montador gerou
		addi s3,zero, 0