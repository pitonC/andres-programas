.data
matrix1: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10       // Matriz 1 de 2x5
matrix2: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0        // Matriz 2 de 2x5
result: .zero 40                                  // Matriz resultado de 2x5
msg_before: .asciz "Matriz 1:\n"
msg_after: .asciz "Matriz 2:\n"
msg_result: .asciz "Matriz Resultante:\n"
msg_elem: .asciz "%d "                             // Formato para imprimir cada elemento
msg_nl: .asciz "\n"                                // Nueva línea

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

    // Sumar matrices
    adrp x0, matrix1
    add x0, x0, :lo12:matrix1
    adrp x1, matrix2
    add x1, x1, :lo12:matrix2
    adrp x2, result
    add x2, x2, :lo12:result
    mov x3, #10                                  // Número de elementos (2x5)

sum_loop:
    cmp x3, #0
    beq done_sum
    ldr w4, [x0], #4                             // Cargar elemento de matrix1
    ldr w5, [x1], #4                             // Cargar elemento de matrix2
    add w6, w4, w5                               // Sumar
    str w6, [x2], #4                             // Almacenar en result
    sub x3, x3, #1
    b sum_loop

done_sum:
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
    mov w21, #10                                    // Número de elementos en cada matriz

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
