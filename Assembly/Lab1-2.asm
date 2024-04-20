#Calcule 8 fatorial.

		addi s0, zero,8
		addi s2,zero,1
		
	fatorial:add s1,zero,s0
		add s3,zero,s2
		addi s2,zero,0
	multiply:add s2,s2,s3
		addi s1,s1,-1
		bne s1,zero,multiply
		addi s0,s0,-1
		bne s0,zero,fatorial