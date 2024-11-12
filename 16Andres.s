.data
array: .word 64, 25, 12, 22, 11  // Arreglo desordenado de enteros de 32 bits
size: .word 5                    // Tamaño del arreglo
msg_before: .asciz "Arreglo antes de ordenar:\n"
msg_after: .asciz "Arreglo después de ordenar:\n"
msg_elem: .asciz "%d "            // Formato para imprimir cada elemento
msg_nl: .asciz "\n"               // Nueva línea

.text
.global main

main:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Imprimir mensaje de arreglo antes de ordenar
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf

    // Imprimir arreglo antes de ordenar
    bl print_array

    // Ordenar arreglo usando el algoritmo de burbuja
    adrp x0, array
    add x0, x0, :lo12:array
    ldr w1, [x0, size]            // Cargar el tamaño del arreglo
    sub w1, w1, #1                // Reducir el tamaño para comparación (n-1)

bubble_sort_outer:
    cmp w1, #0
    beq done_sort
    mov w2, #0                    // Índice para comparaciones internas

bubble_sort_inner:
    cmp w2, w1
    bge next_outer
    ldr w3, [x0, w2, LSL #2]      // Cargar array[i] (32-bit)
    ldr w4, [x0, w2, LSL #2 + 4]  // Cargar array[i+1] (32-bit)

    // Si array[i] > array[i+1], intercambiar
    cmp w3, w4
    blt no_swap

    // Intercambiar
    str w4, [x0, w2, LSL #2]      // array[i] = array[i+1] (32-bit)
    str w3, [x0, w2, LSL #2 + 4]  // array[i+1] = array[i] (32-bit)

no_swap:
    add w2, w2, #1
    b bubble_sort_inner

next_outer:
    sub w1, w1, #1
    b bubble_sort_outer

done_sort:
    // Imprimir mensaje de arreglo después de ordenar
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf

    // Imprimir arreglo después de ordenar
    bl print_array

    // Restaurar y retornar
    ldp x29, x30, [sp], 16
    ret

// Subrutina para imprimir el arreglo
print_array:
    stp x29, x30, [sp, -16]!
    adrp x19, array
    add x19, x19, :lo12:array
    ldr w20, [x19, size]            // Cargar el tamaño del arreglo
    mov w21, #0                     // Índice

print_loop:
    cmp w21, w20
    bge print_end
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w21, LSL #2]      // Cargar el elemento del arreglo (32-bit)
    bl printf
    add w21, w21, #1
    b print_loop

print_end:
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    ldp x29, x30, [sp], 16
    ret
