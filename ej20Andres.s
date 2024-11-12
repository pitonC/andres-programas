.global _start

.section .data
    matriz1: .word 1, 2, 3, 4 // Matriz 2x2
    matriz2: .word 5, 6, 7, 8 // Matriz 2x2
    resultado: .word 0, 0, 0, 0
    longitud: .word 2

.section .text
_start:
    // inicializar punteros y cargar longitud
    ldr r0, =matriz1         // Cargar la dirección de la primera matriz
    ldr r1, =matriz2         // Cargar la dirección de la segunda matriz
    ldr r2, =resultado       // Cargar la dirección del resultado
    ldr r3, =longitud        // Cargar la longitud
    ldr r3, [r3]             // Cargar la longitud

    mov r4, #0               // Inicializar el índice i

multiplicar_matrices:
    cmp r4, r3               // Si el índice es mayor, termina
    bge fin_multiplicacion

    mov r5, #0               // Inicializar el índice j
    multiplicar_filas_columnas:
        cmp r5, r3           // Comparar el índice j con la longitud
        bge siguiente_fila

        ldr r6, [r0, r4, lsl #2] // Cargar el valor de la fila de la primera matriz
        ldr r7, [r1, r5, lsl #2] // Cargar el valor de la columna de la segunda matriz
        mul r8, r6, r7        // Multiplicar

        add r9, r9, r8        // Acumular el resultado en r9

        add r5, r5, #1
        b multiplicar_filas_columnas

    siguiente_fila:
        str r9, [r2, r4, lsl #2] // Guardar el resultado en la matriz de resultados

        add r4, r4, #1           // Incrementar el índice i
        mov r9, #0               // Reiniciar el acumulador
        b multiplicar_matrices

fin_multiplicacion:
    mov r7, #1               // syscall exit
    swi 0
