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

seleccion_loop:
    mov r2, r3               // Inicializar el índice mínimo
    mov r3, r1               // Establecer índice de comparación
    cmp r3, r1               // Si el índice es mayor, termina
    bge fin_seleccion

    ldr r4, [r0, r2, lsl #2] // Cargar el valor mínimo
    mov r5, r4

    // Encontrar el índice mínimo
    add r6, r2, #1
    cmp r6, r1
    bge siguiente_elemento

    ldr r7, [r0, r6, lsl #2]
    cmp r7, r5

siguiente_elemento:
    mov r5, r7
    b seleccion_loop
fin_seleccion:
    mov r7, #1 // syscall exit
    swi 0
