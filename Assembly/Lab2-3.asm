		li  s3,0x12345678 # são pseudoinstruções
		li  t1,0x10010034 # (exceto a última)
		sw   s3,(t1)       # <= observe o efeito na memória!

		
		lb t2, 0(t1)
		lb t3, 3(t1)
		sb t2, 3(t1)
		sb t3, 0(t1)
		