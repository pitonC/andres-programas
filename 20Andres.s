.data
matrix1: .word 1, 2, 3, 4       // Matriz 2x2
matrix2: .word 5, 6, 7, 8       // Matriz 2x2
result: .zero 16               // Matriz resultado 2x2
msg_before: .asciz "Matriz 1:\n"
msg_after: .asciz "Matriz 2:\n"
msg_result: .asciz "Matriz Resultante:\n"
msg_elem: .asciz "%d "          // Formato para imprimir cada elemento
msg_nl: .asciz "\n"             // Nueva línea

.text
.global main

main:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Imprimir mensaje de matriz 1
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf

    // Imprimir matriz 1
    bl print_matrix

    // Imprimir mensaje de matriz 2
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf

    // Imprimir matriz 2
    bl print_matrix

    // Multiplicar matrices
    adrp x0, matrix1
    add x0, x0, :lo12:matrix1
    adrp x1, matrix2
    add x1, x1, :lo12:matrix2
    adrp x2, result
    add x2, x2, :lo12:result
    mov x3, #2                // Filas de la matriz 1
    mov x4, #2                // Columnas de la matriz 2

multiply_outer:
    cmp x3, #0
    beq done_multiply
    mov x5, #0                // Inicializar columna de la matriz resultado

multiply_inner:
    cmp x5, #2
    beq next_row
    mov w6, #0                // Acumulador de la multiplicación

    // Realizar multiplicación de la fila y columna
    mov x7, #0                // Iterador para el producto punto
multiply_dot_product:
    ldr w8, [x0, x7, LSL #2]  // Cargar elemento de la fila de matrix1
    ldr w9, [x1, x5, LSL #2]  // Cargar elemento de la columna de matrix2
    mul w10, w8, w9           // Multiplicar
    add w6, w6, w10           // Sumar al acumulador
    add x7, x7, #1
    cmp x7, #2
    bne multiply_dot_product

    // Guardar el resultado en la matriz
    str w6, [x2, x3, LSL #2]  // Almacenar en la posición correspondiente
    add x5, x5, #1
    b multiply_inner

next_row:
    add x3, x3, #1
    b multiply_outer

done_multiply:
    // Imprimir mensaje de matriz resultado
    adrp x0, msg_result
    add x0, x0, :lo12:msg_result
    bl printf

    // Imprimir matriz resultante
    bl print_matrix

    // Restaurar y retornar
    ldp x29, x30, [sp], 16
    ret

// Subrutina para imprimir la matriz
print_matrix:
    stp x29, x30, [sp, -16]!
    adrp x19, matrix1
    add x19, x19, :lo12:matrix1
    mov w20, #0
    mov w21, #4                // Número de elementos en cada matriz

print_loop:
    cmp w20, w21
    bge print_end
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w20, UXTW #2]
    bl printf
    add w20, w20, #1
    b print_loop

print_end:
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    ldp x29, x30, [sp], 16
    ret
