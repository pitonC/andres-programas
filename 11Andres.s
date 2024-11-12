.data
string: .asciz "madam"            // Cadena a verificar
msg_palindrome: .asciz "La cadena es un palíndromo.\n"
msg_not_palindrome: .asciz "La cadena NO es un palíndromo.\n"
msg_input: .asciz "Ingrese una cadena: "
msg_newline: .asciz "\n"

.text
.global main

main:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Imprimir mensaje para ingresar la cadena
    adrp x0, msg_input
    add x0, x0, :lo12:msg_input
    bl printf

    // Leer la cadena de entrada
    adrp x0, string
    add x0, x0, :lo12:string
    bl scanf

    // Cargar la cadena a verificar
    adrp x0, string
    add x0, x0, :lo12:string
    bl is_palindrome

    // Finalizar el programa
    ldp x29, x30, [sp], 16
    ret

// Subrutina para verificar si una cadena es un palíndromo
is_palindrome:
    // x0 = dirección de la cadena
    mov x1, x0                  // Copiar dirección de la cadena a x1
    bl strlen                    // Llamar a strlen para obtener la longitud de la cadena
    mov x2, x0                   // Guardar la longitud de la cadena en x2

    // Preparar el puntero de la cadena reversa
    add x3, x1, x2               // x3 apunta al final de la cadena
    sub x3, x3, #1               // Ajuste de puntero (apuntar al último carácter)

    // Comparar los caracteres desde los dos extremos
compare_loop:
    cmp x1, x3                   // Compara los punteros (inicio y fin)
    bge palindrome_found         // Si se encuentran, es un palíndromo

    ldrb w4, [x1]                // Cargar el carácter de la izquierda
    ldrb w5, [x3]                // Cargar el carácter de la derecha

    cmp w4, w5                   // Comparar los caracteres
    bne not_palindrome           // Si no son iguales, no es un palíndromo

    add x1, x1, #1               // Avanzar el puntero de la izquierda
    sub x3, x3, #1               // Retroceder el puntero de la derecha
    b compare_loop               // Continuar comparando

palindrome_found:
    adrp x0, msg_palindrome
    add x0, x0, :lo12:msg_palindrome
    bl printf
    ret

not_palindrome:
    adrp x0, msg_not_palindrome
    add x0, x0, :lo12:msg_not_palindrome
    bl printf
    ret

// Subrutina para obtener la longitud de una cadena
strlen:
    mov x0, x0                   // Dirección de la cadena en x0
    mov x1, #0                   // Inicializar el contador de longitud

strlen_loop:
    ldrb w2, [x0, x1]            // Cargar el siguiente byte de la cadena
    cmp w2, #0                   // Verificar si llegamos al final de la cadena (carácter nulo)
    beq strlen_done              // Si es 0, terminamos
    add x1, x1, #1               // Incrementar el índice
    b strlen_loop                // Repetir

strlen_done:
    mov x0, x1                   // Devolver la longitud en x0
    ret
