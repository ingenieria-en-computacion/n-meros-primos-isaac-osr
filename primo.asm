section .data
    msg1 db "Ingrese un numero: ",0     ;Mensajes para el usuario
    msg2 db "El numero no es primo",0
    msg3 db "El numero es primo",0

section .text
    global _start
    %include "io.asm"

_start:
    sub esp, 4      ;Reservamos espacio para a

    mov esi, msg1   ;Imprimir mensaje 1
    call print_str

    call scan_num   ;Leer a

    mov [esp], eax  ;Meter a en la pila

    cmp eax,1       ;Caso especial para a=1
    je .par

    cmp eax, 2      ;Caso especial para a=2
    mov ecx,2
    je .fin_while

    mov ebx, 2      ;Averiguamos si a es par
    xor edx, edx
    div ebx
    cmp dl,0
    je .par

    mov ecx, 3      ;Averiguamos si a tiene mas divisores con un ciclo
.while:
    mov eax, [esp]
    cmp ecx, eax
    jae .fin_while

    xor edx,edx     ;Si tiene sale del ciclo
    div ecx
    cmp edx, 0
    je .par

    add ecx, 2
    jmp .while

.fin_while:         ;Al terminar el ciclo evalua una candicion para saber si es primo
    mov eax, [esp]
    cmp ecx, eax
    jl .par
    mov esi, msg3
    call print_str
    jmp .fin

.par:               ;Caso si no es primo
    mov esi, msg2
    call print_str
    jmp .fin

.fin:               ;Final del programa
    add esp, 4

    mov eax, 1
    xor ebx, ebx
    int 0x80