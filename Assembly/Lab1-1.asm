#calcule o somatorio de i^2 para i de 1 a 20.

			addi s0,zero,20
	somatorio:	add s1,zero,s0
	quadratic:	add s3, s3,s0
			addi s1,s1,-1
			bne s1, zero, quadratic
			addi s0,s0,-1
			bne s0,zero,somatorio