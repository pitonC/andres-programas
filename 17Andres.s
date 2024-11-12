.data
array: .word 12, 45, 7, 23, 67, 89, 34, 56, 90, 14    // Datos de entrada: arreglo de números
arr_len: .word 10                                      // Longitud del arreglo
msg_before: .asciz "Arreglo antes de ordenar:\n"         // Mensaje antes de ordenar
msg_after: .asciz "Arreglo después de ordenar:\n"        // Mensaje después de ordenar
msg_elem: .asciz "%d "                                  // Formato para imprimir cada elemento
msg_nl: .asciz "\n"                                     // Nueva línea

.text
.global main

main:
    // Guardamos los registros de retorno
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Mostrar el arreglo sin ordenar
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf
    bl print_array

    // Inicializar variables para el ordenamiento por selección
    adrp x0, arr_len
    add x0, x0, :lo12:arr_len
    ldr w0, [x0]        // w0 = longitud del arreglo
    sub w1, w0, #1      // w1 = n-1 para el bucle externo

outer_loop:
    cmp w1, #0          // Verificar si terminamos
    blt done_sort       // Si w1 < 0, terminamos
    
    mov w2, w1          // w2 = índice del mayor actual
    mov w3, w1          // w3 = contador para el bucle interno

inner_loop:
    cmp w3, #0          // Comprobar si llegamos al inicio
    blt end_inner       // Si w3 < 0, fin del bucle interno
    
    // Cargar elementos para comparar
    adrp x4, array
    add x4, x4, :lo12:array
    lsl w5, w3, #2      // Desplazar índice para cálculo del offset
    add x5, x4, w5, UXTW
    lsl w6, w2, #2
    add x6, x4, w6, UXTW
    
    ldr w7, [x5]        // Cargar valor del arreglo
    ldr w8, [x6]        // Cargar el valor máximo actual
    
    // Comparar valores
    cmp w7, w8
    ble no_update       // Si no es mayor, no actualizamos
    mov w2, w3          // Actualizar el índice del máximo

no_update:
    sub w3, w3, #1      // Decrementar contador interno
    b inner_loop

end_inner:
    cmp w2, w1          // Verificar si ya está en su lugar
    beq no_swap         // Si no es necesario intercambiar, continuar
    
    // Intercambio de elementos
    adrp x4, array
    add x4, x4, :lo12:array
    lsl w5, w1, #2
    add x5, x4, w5, UXTW
    lsl w6, w2, #2
    add x6, x4, w6, UXTW
    
    ldr w7, [x5]        // Elemento actual
    ldr w8, [x6]        // Elemento máximo
    str w8, [x5]        // Guardar el máximo en la posición actual
    str w7, [x6]        // Guardar el valor actual en la posición del máximo

no_swap:
    sub w1, w1, #1      // Decrementar índice para el siguiente paso
    b outer_loop

done_sort:
    // Imprimir mensaje y mostrar el arreglo ordenado
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf
    bl print_array

    // Restaurar registros y retornar
    ldp x29, x30, [sp], 16
    ret

// Subrutina para imprimir el arreglo
print_array:
    stp x29, x30, [sp, -16]!    // Guardar el estado de los registros
    
    adrp x19, array             // Dirección de inicio del arreglo
    add x19, x19, :lo12:array
    adrp x20, arr_len
    add x20, x20, :lo12:arr_len
    ldr w20, [x20]              // Cargar longitud del arreglo
    mov w21, #0                 // Inicializamos el índice

print_loop:
    cmp w21, w20                // Verificar si llegamos al final del arreglo
    bge print_end               // Si es así, terminamos
    
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w21, UXTW #2] // Cargar el siguiente elemento
    bl printf
    
    add w21, w21, #1            // Incrementar el índice
    b print_loop

print_end:
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    
    ldp x29, x30, [sp], 16      // Restaurar el estado
    ret
