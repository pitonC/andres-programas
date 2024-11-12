.section .data
array:      .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19   // Array ordenado para búsqueda
size:       .word 10                                  // Tamaño del array
not_found:  .asciz "El número no se encuentra en el array.\n"
found:      .asciz "Número encontrado en la posición: "
prompt:     .asciz "Introduce el número a buscar: "
newline:    .asciz "\n"

.section .bss
.comm input, 4                                        // Espacio para el número del usuario

.section .text
.global _start

// Función de búsqueda binaria
bin_search:
    cmp x1, x2                // Si low > high, no encontrado
    bgt not_found_label

    // Calcular índice medio
    add x3, x1, x2
    lsr x3, x3, 1             // mid = (low + high) / 2

    ldr w4, [x0, x3, lsl 2]   // array[mid]
    cmp w4, w5                // Comparar array[mid] con target
    beq found_label

    blt search_left
search_right:
    add x1, x3, 1             // low = mid + 1
    b bin_search

search_left:
    sub x2, x3, 1             // high = mid - 1
    b bin_search

found_label:
    // Mostrar mensaje de posición encontrada
    mov x0, 1                 // syscall write
    mov x1, 1                 // salida en pantalla
    ldr x2, =found
    mov x3, 31                // longitud del mensaje
    svc 64                    // llamada a syscall write

    // Mostrar posición como número (simplificado)
    add w0, w3, '0'           // Convertir el número en carácter ASCII
    mov x1, 1                 // salida en pantalla
    mov x2, x0                // posición en el array
    mov x3, 1                 // longitud de un carácter
    svc 64                    // llamada a syscall write
    b exit                    // Salir del programa

not_found_label:
    // Mostrar mensaje de no encontrado
    mov x0, 1                 // syscall write
    mov x1, 1                 // salida en pantalla
    ldr x2, =not_found
    mov x3, 35                // longitud del mensaje
    svc 64                    // llamada a syscall write
    b exit                    // Salir del programa

exit:
    mov x8, 93                // syscall exit
    mov x0, 0                 // código de salida 0
    svc 0

_start:
    // Imprimir mensaje de introducción
    mov x0, 1                 // syscall write
    mov x1, 1                 // salida en pantalla
    ldr x2, =prompt
    mov x3, 29                // longitud del mensaje
    svc 64                    // llamada a syscall write

    // Leer el número ingresado
    mov x0, 0                 // syscall read
    mov x1, 0                 // entrada de teclado
    ldr x2, =input
    mov x3, 4                 // longitud de entrada
    svc 63                    // llamada a syscall read

    // Cargar el número ingresado en w5
    ldr x6, =input
    ldr w5, [x6]              // cargar el valor de input
    ldr x0, =array            // Dirección base del array
    mov x1, 0                 // low = 0
    ldr w2, =size
    ldr w2, [x2]              // cargar tamaño del array en w2
    sub x2, x2, 1             // high = size - 1
    bl bin_search             // Llamar a búsqueda binaria
