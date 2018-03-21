segment .data
	message db 'EL	 RESULTADO DE ES : ',0xA,0xD
	length: equ $-message
segment .bss
	a1 resb 1
	b1 resb 1
	c1 resb 1

	res1 resb 1

	a2 resb 1 
	b2 resb 1
	c2 resb 1

	res2 resb 1

	resultadoIntegral resb 1
section  .text
	global _start  ;must be declared for using gcc
	_start:

;trabajando con el primer termino 4X

	mov eax,4
	mov ebx,2
	mul ebx
	mov [a1],eax

;trabajando con el segundo termino (3X^2)/2
	;se eleva 2 al cuadrdo
	mov eax,2
	mov ecx,2
	mul ecx
	;se multiplica por 3
	mov ebx,3
	mul ebx
	;se divide entre 2	
	mov ebx,2
	div ebx
    mov [b1],eax
;se suma a el primer resultado al segundo (a+b)
	mov eax,[a1]
	mov ebx,[b1]
	add eax,ebx
	;add eax,'0'
	mov [res1],eax
 

;trabajando con el tercer termino (3X^3)/3
	;se eleva 2 al cubo
	mov eax,2
	mov ecx,2
	mul ecx
	mul ecx
	;se multiplica por la constante 3
	mov ebx,3
	mul ebx
	;se divide entre de 3 que es la potencia de x
	mov ebx,3 
	div ebx

;se resta el tercer termino a el resultado anterior
	mov ebx,[res1]
	sub ebx,eax

	mov [res1], ebx;resultado evaluando la ecuacion con 2

;trabajando con el primer termino 4X

	mov eax,4
	mov ebx,0
	mul ebx
	mov [a2],eax

;trabajando con el segundo termino (3X^2)/2
	;se eleva 0 al cuadrdo
	mov eax,0
	mov ecx,0
	mul ecx
	;se multiplica por 3
	mov ebx,3
	mul ebx
	;se divide entre 2	
	mov ebx,2
	div ebx
    mov [b2],eax
;se suma a el primer resultado al segundo (a+b)
	mov eax,[a2]
	mov ebx,[b2]
	add eax,ebx
	;add eax,'0'
	mov [res2],eax
 

;trabajando con el tercer termino (3X^3)/3
	;se eleva 0 al cubo
	mov eax,0
	mov ecx,0
	mul ecx
	mul ecx
	;se multiplica por la constante 3
	mov ebx,3
	mul ebx
	;se divide entre de 3 que es la potencia de x
	mov ebx,3 
	div ebx

;se resta el tercer termino a el resultado anterior
	mov ebx,[res2]
	sub ebx,eax

	mov [res2], ebx;resultado evaluando la ecuacion con 0

	
;se resta la parte evaluada con 2 a la parte evaluada con 0
	
	mov eax,[res1]
	mov ebx,[res2]
	sub eax,ebx

	add eax,'0'
	mov [resultadoIntegral],eax
;impresion
	mov eax,4
	mov ebx,1
	mov ecx,resultadoIntegral
	mov edx,1
	int 0x80

	mov eax, 4        ; sys_write syscall
    mov ebx, 1        ; stdout
    mov ecx, message    ; message address
    mov edx, length        ; message string length
    int 80h

	mov eax, 1        ; sys_exit syscall

    mov ebx, 0        ; return 0 (success)

    int 80h