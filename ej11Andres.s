.global _start

.section .data
    cadena: .asciz "radar"   // La cadena a verificar
    longitud: .word 0          // Variable para almacenar la longitud de la cadena

.section .text
_start:
    // obtener la longitud de la cadena
    ldr r0, =cadena         // Cargar la dirección de la cadena
    bl string_length        // Llamar a la función string_length

    // Guardar la longitud de la cadena
    ldr r1, =longitud       // Cargar la dirección de la longitud
    str r0, [r1]            // Guardar el valor de longitud

    // Verificar si la cadena es un palíndromo
    mov r2, #0              // Índice de inicio (0)
    ldr r3, [r1]            // Cargar la longitud
    sub r3, r3, #1          // Ajustar longitud para el índice final

palindromo_loop:
    cmp r2, r3              // Comparar si el índice de inicio es mayor o igual al de fin
    bge es_palindromo       // Si es mayor o igual, ya hemos terminado

    // Comparar los caracteres en los extremos
    ldrb r4, [r0, r2]       // Cargar el carácter en la posición de inicio
    ldrb r5, [r0, r3]       // Cargar el carácter en la posición final
    cmp r4, r5              // Comparar los caracteres
    bne no_palindromo       // Si son diferentes, no es palíndromo

    // Incrementar el índice de inicio y decrementar el de fin
    add r2, r2, #1
    sub r3, r3, #1
    b palindromo_loop

es_palindromo:
    mov r0, #1              // Retornar 1 para palíndromo
    b fin

no_palindromo:
    mov r0, #0              // Retornar 0 para no palíndromo

fin:
    mov r7, #1              // syscall exit
    swi 0

// Función para calcular la longitud de una cadena
string_length:
    mov r1, #0              // Contador de longitud
length_loop:
    ldrb r2, [r0, r1]       // Cargar el siguiente carácter
    cmp r2, #0              // Comparar con null (fin de cadena)
    beq end_length          // Si es null, termina
    add r1, r1, #1          // Incrementar el contador
    b length_loop

end_length:
    mov r0, r1              // Devolver la longitud de la caden
    bx lr
