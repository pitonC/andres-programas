/*
// Nombre del Programa: SegundoMayorAndres.py
// Descripción: Este programa encuentra el segundo elemento más grande en un arreglo dado.
// Captura de datos: El usuario ingresa los elementos del arreglo.
// Resultado: El programa muestra el segundo elemento más grande del arreglo.
// Ejemplo:
//    Entrada:
//        Ingresa los elementos del arreglo (separados por espacio): 10 20 4 45 99
//    Salida:
//        El segundo elemento más grande es: 45

// Función para encontrar el segundo elemento más grande
def segundo_mayor(arr):
    arr_unicos = list(set(arr))  // Eliminar duplicados
    arr_unicos.sort()            // Ordenar el arreglo de menor a mayor
    return arr_unicos[-2]        // Retornar el segundo elemento más grande

// Captura de datos desde el usuario
arr = list(map(int, input("Ingresa los elementos del arreglo (separados por espacio): ").split()))

// Verificar que el arreglo tenga al menos dos elementos
if len(arr) < 2:
    print("El arreglo debe contener al menos dos elementos.")
else:
    // Calcular el segundo mayor
    resultado = segundo_mayor(arr)
    // Mostrar el resultado
    print(f"El segundo elemento más grande es: {resultado}")

// Este es un programa en ARM64 que encuentra el segundo elemento más grande en un arreglo.
*/
.global _start

.section .data
    arr:    .word 10, 20, 4, 45, 99  // Arreglo con los elementos
    size:   .word 5                   // Tamaño del arreglo

.section .bss

.section .text

_start:
    // Cargar la dirección del arreglo y el tamaño
    LDR R0, =arr                // Cargar la dirección del arreglo
    LDR R1, =size               // Cargar la dirección del tamaño
    LDR R1, [R1]                // Cargar el tamaño del arreglo en R1
    MOV R2, #0                  // Inicializar el mayor número en 0
    MOV R3, #0                  // Inicializar el segundo mayor número en 0

    // Recorrer el arreglo
    MOV R4, #0                  // Índice para recorrer el arreglo
FIND_LOOP:
    CMP R4, R1                  // Comprobar si hemos recorrido todos los elementos
    BEQ DONE                    // Si hemos recorrido todos, terminamos

    LDR R5, [R0, R4, LSL #2]    // Cargar el siguiente elemento del arreglo en R5

    // Verificar si el elemento es mayor que el primer número
    CMP R5, R2                  // Compara el valor con el mayor
    BLE CHECK_SECOND            // Si es menor o igual, no cambiar el mayor
    MOV R3, R2                  // El segundo mayor pasa a ser el anterior mayor
    MOV R2, R5                  // El mayor número ahora es el actual
    B CONTINUE

CHECK_SECOND:
    // Verificar si el elemento es mayor que el segundo mayor pero menor que el primero
    CMP R5, R3                  // Compara el valor con el segundo mayor
    BLE CONTINUE                // Si es menor o igual, no hacer nada
    MOV R3, R5                  // El segundo mayor número es el actual

CONTINUE:
    ADD R4, R4, #1              // Incrementar el índice
    B FIND_LOOP                 // Continuar el ciclo

DONE:
    // El segundo mayor número está en R3
    MOV R7, #1                  // Sistema de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0
