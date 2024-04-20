#Faça   manualmente   a   codificação   das   seguintes   instruções   para   o   código   de   máquina
#hexadecimal respectivo, consultando a tabela ao final do arquivo:

		add t3,zero,s7
#32 bits -> 7 5 5 3 5 7 tipo R
#00000001011100000000111000110011 -> 0x1700e33
		addi s1,s1,1
#32 bits -> 12 5 3 5 7 tipo I
#0000 0000 0001  0100 1000 0100 1001 0011 -> 0x0148493
		sub t6,t5,t4
#32 bits -> 7 5 5 3 5 7 tipo R
#0100000 11101 11110 000 11111 0110011 -> 0x41DF0FB3
		addi t1,t4,123
#32 bits 0-> 12 5 3 5 7 tipo I 
#000001111011 11101 000 00110 0010011 -> 0x7BE8313

#Escreva   as   instruções   completas   executadas   pelo   processador   RISC-V   ao   encontrar   os
#seguintes códigos de máquina, novamente consultando a tabela manualmente.

#•0x0169 02B3
#0000000 10110 10010 000 00101 0110011 TIPO R
# func7   x22   X18   func3  x5  opcode   
		add t0,s2,s6
#•0x0576 0693
#000001010111 01100 000 01101 0010011 TIPO I
#000 0101 0111  x12  0    x13   addi
#0x57 -> 87d
		addi a3,a2,87

#•0x0109 E413
#000000010000 10011 110 01000 0010011 TIPO I
#16		x19 fun3 x8	ori
		ori s0,s3,16