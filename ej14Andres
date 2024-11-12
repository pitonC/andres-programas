.global _start

.section .data
    arreglo: .word 10, 20, 30, 40, 50 // Arreglo de ejemplo
    longitud: .word 5                   // Longitud del arreglo
    objetivo: .word 30                  // Valor objetivo a buscar

.section .text
_start:
    // Inicializar puntero y cargar longitud y objetivo
    ldr r0, =arreglo         // Cargar la dirección del arreglo
    ldr r1, =longitud        // Cargar la longitud
    ldr r1, [r1]             // Cargar la longitud
    ldr r2, =objetivo        // Cargar el valor objetivo
    ldr r2, [r2]             // Cargar el valor objetivo

    mov r3, #0              // Inicializar el índice en 0

busqueda_lineal:
    cmp r3, r1              // Comparar el índice con la longitud
    bge no_encontrado       // Si el índice es mayor o igual a la longitud, termina

    ldr r4, [r0, r3, lsl #2] // Cargar el valor del arreglo en la posición indicada
    cmp r4, r2              // Comparar el valor con el objetivo
    beq encontrado          // Si es igual, objetivo encontrado

    add r3, r3, #1          // Incrementar el índice
    b busqueda_lineal

encontrado:
    mov r0, #1              // Retornar 1 para indicar que se encontró el valor
    b fin

no_encontrado:
    mov r0, #0              // Retornar 0 para indicar que no se encontró el valor

fin:
    mov r7, #1              // syscall exit
    swi 0
