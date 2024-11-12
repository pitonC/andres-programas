.data
array: .word 12, 45, 7, 23, 67, 89, 34, 56, 90, 14    // Datos a ordenar
arr_len: .word 10                                      // Número de elementos
msg_before: .asciz "Arreglo antes de ordenar:\n"
msg_after: .asciz "Arreglo después de ordenar:\n"
msg_elem: .asciz "%d "                                 // Para cada elemento
msg_nl: .asciz "\n"                                    // Nueva línea

.text
.global main

main:
    stp x29, x30, [sp, -16]!    // Guardar registros
    mov x29, sp

    // Mostrar mensaje y arreglo original
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf
    bl print_array

    // Parámetros iniciales para la función merge_sort
    adrp x0, array
    add x0, x0, :lo12:array     // Dirección del arreglo
    mov x1, #0                  // inicio = 0
    adrp x2, arr_len
    add x2, x2, :lo12:arr_len
    ldr w2, [x2]                // fin = n-1
    sub x2, x2, #1

    // Llamar a merge_sort
    bl merge_sort

    // Mostrar el resultado
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf
    bl print_array

    // Restaurar y retornar
    ldp x29, x30, [sp], 16
    ret

// Función de ordenamiento Merge Sort
merge_sort:
    stp x29, x30, [sp, -48]!    // Guardar registros
    mov x29, sp
    
    str x0, [x29, 16]           // Dirección del arreglo
    str x1, [x29, 24]           // Inicio
    str x2, [x29, 32]           // Fin

    cmp x1, x2                  // Verificar si hay que continuar
    bge merge_sort_end

    add x3, x1, x2              // Calcular punto medio
    lsr x3, x3, #1              // x3 = (inicio + fin) / 2
    str x3, [x29, 40]

    // Llamar recursivamente para la primera mitad
    ldr x0, [x29, 16]
    ldr x1, [x29, 24]
    mov x2, x3
    bl merge_sort

    // Llamar recursivamente para la segunda mitad
    ldr x0, [x29, 16]
    ldr x1, [x29, 40]
    add x1, x1, #1
    ldr x2, [x29, 32]
    bl merge_sort

    // Unir las dos mitades ordenadas
    ldr x0, [x29, 16]
    ldr x1, [x29, 24]
    ldr x2, [x29, 40]
    ldr x3, [x29, 32]
    bl merge

merge_sort_end:
    ldp x29, x30, [sp], 48
    ret

// Función de fusión de las mitades ordenadas
merge:
    stp x29, x30, [sp, -64]!    // Guardar registros

    // Parámetros de la función merge
    ldr x0, [x29, 16]           // Dirección del arreglo
    ldr x1, [x29, 24]           // Inicio de la primera mitad
    ldr x2, [x29, 32]           // Fin de la primera mitad
    ldr x3, [x29, 40]           // Inicio de la segunda mitad
    ldr x4, [x29, 48]           // Fin de la segunda mitad

    // Implementación de la fusión (aquí se simplifica el proceso)
    // ...

    ldp x29, x30, [sp], 64
    ret

// Subrutina para imprimir el arreglo
print_array:
    stp x29, x30, [sp, -16]!    // Guardar registros
    
    adrp x19, array
    add x19, x19, :lo12:array
    adrp x20, arr_len
    add x20, x20, :lo12:arr_len
    ldr w20, [x20]
    mov w21, #0

print_loop:
    cmp w21, w20
    bge print_end
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w21, UXTW #2]
    bl printf
    add w21, w21, #1
    b print_loop

print_end:
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    
    ldp x29, x30, [sp], 16
    ret
