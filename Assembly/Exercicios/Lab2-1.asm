#Armazene   uma   sequência   crescente   de   1000   valores   na   memória   a   partir   do   endereço
#0x1001 1234
		#addi s8, zero, 999
		#li t1,0x10011234
	#sequency:
		#sw s1,(t1)
		#addi t1,t1,4
		#addi s1,s1,1
		#ble s1,s8,sequency
		
#Transfira 40 words de 32 bits a partir do endereço 0x1001 0100 para a região de memória
#iniciada em 0x1001 1100. Insira alguns dados para poder visualizar a simulação ocorrendo.

		addi s8, zero, 40
		li t1,0x10010100
	sequency2:
		sw s1,(t1)
		addi t1,t1,4
		addi s1,s1,1
		ble s1,s8,sequency2 #INICIALIZAR DADOS
	
		li t1,0x10010100 #Endereco de origem
		li t2,0x10011100 #Endereci de destino
		
	transfer: lw s2, (t1)
		sw zero, (t1)	#TRANSFERIR DADOS
		sw s2, (t2)
		addi t1,t1,4
		addi t2,t2,4
		addi s1,s1, -1
		bgtz s1,transfer