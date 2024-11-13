/*
// Nombre del Programa: InvertirArregloAndres.py
// Descripción: Este programa invierte los elementos de un arreglo dado.
// Captura de datos: El usuario ingresa los elementos del arreglo como una lista de números.
// Resultado: El programa muestra el arreglo con los elementos invertidos.
// Ejemplo:
//    Entrada:
//        Ingresa los elementos del arreglo (separados por espacio): 1 2 3 4 5
//    Salida:
//        El arreglo invertido es: [5, 4, 3, 2, 1]

// Función para invertir un arreglo
def invertir_arreglo(arr):
    return arr[::-1]

// Captura de datos desde el usuario
arr = list(map(int, input("Ingresa los elementos del arreglo (separados por espacio): ").split()))

// Invertir el arreglo
resultado = invertir_arreglo(arr)

// Mostrar el resultado
print(f"El arreglo invertido es: {resultado}")


// Este es un programa en ARM64 que invierte los elementos de un arreglo.
*/
.global _start

.section .data
    arr:    .word 1, 2, 3, 4, 5  // Arreglo con los elementos
    size:   .word 5               // Tamaño del arreglo

.section .bss

.section .text

_start:
    // Cargar la dirección del arreglo y el tamaño
    LDR R0, =arr                // Cargar la dirección del arreglo
    LDR R1, =size               // Cargar la dirección del tamaño
    LDR R1, [R1]                // Cargar el tamaño del arreglo en R1
    SUB R1, R1, #1              // Decrementar el tamaño (índice máximo)
    MOV R2, #0                  // Inicializar el índice desde el principio

    // Invertir el arreglo
INVERT_LOOP:
    CMP R2, R1                  // Compara los índices
    BGE DONE                    // Si los índices se cruzan, terminamos

    // Intercambiar los elementos
    LDR R3, [R0, R2, LSL #2]    // Cargar el elemento en la posición R2
    LDR R4, [R0, R1, LSL #2]    // Cargar el elemento en la posición R1
    STR R3, [R0, R1, LSL #2]    // Almacenar el valor de R3 en la posición R1
    STR R4, [R0, R2, LSL #2]    // Almacenar el valor de R4 en la posición R2

    // Incrementar y decrementar los índices
    ADD R2, R2, #1              // Incrementar índice desde el inicio
    SUB R1, R1, #1              // Decrementar índice desde el final
    B INVERT_LOOP               // Continuar el ciclo

DONE:
    // Imprimir el resultado (simplemente finalizar para evitar colgar el sistema)
    MOV R7, #1                  // Sistema de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0

