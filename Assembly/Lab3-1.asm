		li a7, 5
		ecall
		mv t0,a0
		addi s2, zero, 2
		add t1, t0, zero
	multi3:	add t0, t0,t1 #result in t0
		addi s2,s2,-1
		bne s2, zero, multi3
				
		addi a2, zero, 1
		add  a0, zero, t0
		addi a7, zero , 64
		ecall
		 