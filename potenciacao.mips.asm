.text
.globl main

# rotina principal do programa, responsavel pela chamada da rotina recursiva
main:
	# inicia a base ($a1) e o expoente ($a1)
        li $a0, 6
        li $a1, 4
        
       # chama a rotina "potencia"
        jal potencia
        
        # imprime o resultado e termina a execucao do programa
        li $v0,1
        syscall
        li $v0,10
        syscall        

# rotina "potencia". eh equivalente ao caso base do codigo de alto nivel
potencia: 
	# verifica se a potencia e igual a zero
        bgt $a1, 0, execucao       # verifica se chegou no final
        # atribui 1 e base para finalizar o calculo
        li $a0, 1                   		
        # chama a rotina "finalizacao"
        j finalizacao                   		# vai para o final
        
 # rotina recursiva respons?vel pelo c?lculo da potenciacao
execucao:
 	# abre um espaco de 8 bits na pilha
 	# salva a base e o endere?o de retorno na pilha e
        subu $sp,$sp,8 
        sw $a0,4($sp)             
        sw $ra,0($sp)
        
        # subtrai o expoente
        subu $a1,$a1,1
        
        # chama recursivamente a rotina "potencia"
        jal potencia 
        
        # recupera da pilha o valor, atribuindo ao registrador $a2 
        lw $ra,0($sp)               
        lw $a2,4($sp)
        
        # remove o espaco da pilha referente aos valores resgatados
        addu $sp,$sp,8
        
        # faz o calculo da potenciacao
        mul $a0,$a0,$a2
        
 # finalizacao e retorno ao endereco resgatado
finalizacao:
        jr $ra