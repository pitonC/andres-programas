.global main
    .text
    .type main, %function

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]!          // Reservar espacio en la pila
    mov x29, sp                       // Establecer el puntero de marco

    // Cargar la dirección de "array" y su longitud
    adrp x0, array                    // Cargar la página base de "array" en x0
    add x0, x0, :lo12:array           // Obtener la dirección del arreglo
    ldr w1, [x0, #4]                  // Cargar la longitud del arreglo (en w1)

    // Inicializar el valor mínimo
    ldr w3, [x0]                      // Cargar el primer elemento en w3
    add x0, x0, #4                    // Mover al siguiente elemento del arreglo
    sub w1, w1, #1                    // Reducir el contador de longitud

loop:
    cbz w1, end_loop                  // Si la longitud es 0, salir del bucle
    ldr w4, [x0]                      // Cargar el siguiente valor
    cmp w3, w4                        // Comparar el valor actual con el mínimo
    csel w3, w3, w4, lt               // Si w4 < w3, actualizar w3 con w4
    add x0, x0, #4                    // Avanzar al siguiente valor
    sub w1, w1, #1                    // Reducir la longitud restante
    b loop                            // Repetir el bucle

end_loop:
    // Mostrar el resultado
    adrp x0, msg_result               // Cargar la dirección del mensaje
    add x0, x0, :lo12:msg_result      // Obtener el mensaje
    mov w1, w3                        // Mover el mínimo encontrado a w1
    bl printf                         // Llamar a printf para imprimir el valor

    // Restaurar el puntero de pila y regresar
    ldp x29, x30, [sp], 16            // Restaurar los registros de marco y retorno
    ret                               // Regresar de la función

    .data
array:      .word 34, 56, 23, 7, 89, 12, 45, 78, 90, 3    // Arreglo con valores diferentes
arr_len:    .word 10                                      // Longitud del arreglo
msg_result: .asciz "El valor mínimo encontrado es: %d\n"   // Mensaje para imprimir
