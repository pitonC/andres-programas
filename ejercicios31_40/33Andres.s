/*
// Nombre del Programa: SumaArregloAndres.py
// Descripción: Este programa suma todos los elementos de un arreglo dado.
// Captura de datos: El usuario ingresa los elementos del arreglo como una lista de números.
// Resultado: El programa muestra la suma total de los elementos del arreglo.
// Ejemplo:
//    Entrada:
//        Ingresa los elementos del arreglo (separados por espacio): 1 2 3 4 5
//    Salida:
//        La suma de los elementos es: 15

// Función para calcular la suma de los elementos de un arreglo
def suma_arreglo(arr):
    return sum(arr)

// Captura de datos desde el usuario
arr = list(map(int, input("Ingresa los elementos del arreglo (separados por espacio): ").split()))

// Calcular la suma
resultado = suma_arreglo(arr)

// Mostrar el resultado
print(f"La suma de los elementos es: {resultado}")

// Este es un programa en ARM64 que calcula la suma de los elementos de un arreglo.
*/
.global _start

.section .data
    arr:    .word 1, 2, 3, 4, 5  // Arreglo con los elementos a sumar
    size:   .word 5               // Tamaño del arreglo
    result: .word 0               // Resultado de la suma

.section .bss

.section .text

_start:
    // Cargar la dirección del arreglo y el tamaño
    LDR R0, =arr                // Cargar la dirección del arreglo
    LDR R1, =size               // Cargar la dirección del tamaño
    LDR R1, [R1]                // Cargar el tamaño del arreglo en R1
    MOV R2, #0                  // Inicializar el índice en 0
    MOV R3, #0                  // Inicializar la suma en 0

    // Sumar los elementos del arreglo
SUM_LOOP:
    CMP R2, R1                  // Compara el índice con el tamaño
    BEQ DONE                    // Si el índice es igual al tamaño, terminamos

    LDR R4, [R0, R2, LSL #2]    // Cargar el siguiente elemento del arreglo (R0 + R2 * 4)
    ADD R3, R3, R4              // Sumar el elemento al acumulador

    ADD R2, R2, #1              // Incrementar el índice
    B SUM_LOOP                  // Volver al ciclo

DONE:
    // Guardar el resultado en la memoria
    LDR R0, =result
    STR R3, [R0]                // Guardar la suma en la variable result

    // Imprimir el resultado (simplemente finalizar para evitar colgar el sistema)
    MOV R7, #1                  // Sistema de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0
