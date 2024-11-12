.global _start

.section .data
    arreglo: .word 50, 40, 30, 20, 10 // Arreglo desordenado
    longitud: .word 5                   // Longitud del arreglo

.section .text
_start:
    // inicializar puntero y cargar longitud
    ldr r0, =arreglo         // Cargar la dirección del arreglo
    ldr r1, =longitud        // Cargar la longitud
    ldr r1, [r1]             // Cargar la longitud
    sub r1, r1, #1           // Limitar el índice a n-1

    mov r2, r3               // Inicializar índices

merge_sort_loop:
    cmp r1, r2               // Si el índice es mayor, termina
    bge fin_ordenamiento

    mov r4, r1               // Dividir el arreglo recursivamente
    b merge_sort_loop

fin_ordenamiento:
    mov r7, #1 // syscall exit
    swi 0
