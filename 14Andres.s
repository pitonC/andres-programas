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

    // Cargar el valor a buscar
    adrp x2, search_value             // Cargar la dirección de "search_value"
    add x2, x2, :lo12:search_value    // Obtener el valor a buscar
    ldr w2, [x2]                      // Cargar el valor a buscar en w2

    // Inicializar el índice
    mov w3, #0                        // Inicializar el índice (w3)

loop:
    cbz w1, end_loop                  // Si la longitud es 0, salir del bucle
    ldr w4, [x0]                      // Cargar el siguiente valor en w4
    cmp w4, w2                        // Comparar el valor con el que buscamos
    beq found                         // Si el valor es igual, ir a "found"
    
    add x0, x0, #4                    // Avanzar al siguiente valor
    add w3, w3, #1                    // Incrementar el índice
    sub w1, w1, #1                    // Reducir la longitud restante
    b loop                            // Repetir el bucle

found:
    // Mostrar el índice del valor encontrado
    adrp x0, msg_result               // Cargar la dirección del mensaje
    add x0, x0, :lo12:msg_result      // Obtener el mensaje
    mov w1, w3                        // Mover el índice a w1 para imprimirlo
    bl printf                         // Llamar a printf para imprimir el índice

end_loop:
    // Restaurar el puntero de pila y regresar
    ldp x29, x30, [sp], 16            // Restaurar los registros de marco y retorno
    ret                               // Regresar de la función

    .data
array:      .word 34, 56, 23, 7, 89, 12, 45, 78, 90, 3    // Arreglo con valores
arr_len:    .word 10                                      // Longitud del arreglo
search_value:.word 7                                      // Valor a buscar
msg_result: .asciz "El valor se encuentra en el índice: %d\n"   // Mensaje para imprimir
