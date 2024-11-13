/*
// Nombre del Programa: RotacionArregloAndres.py
// Descripción: Este programa rota los elementos de un arreglo hacia la izquierda o derecha.
// Captura de datos: El usuario ingresa los elementos del arreglo y la cantidad de posiciones de rotación.
// Resultado: El programa muestra el arreglo con los elementos rotados.
// Ejemplo:
//    Entrada:
//        Ingresa los elementos del arreglo (separados por espacio): 1 2 3 4 5
//        Ingresa el número de posiciones para la rotación: 2
//        Ingresa la dirección de la rotación (izquierda o derecha): izquierda
//    Salida:
//        El arreglo rotado hacia la izquierda es: [3, 4, 5, 1, 2]

// Función para rotar un arreglo hacia la izquierda
def rotar_izquierda(arr, posiciones):
    return arr[posiciones:] + arr[:posiciones]

// Función para rotar un arreglo hacia la derecha
def rotar_derecha(arr, posiciones):
    return arr[-posiciones:] + arr[:-posiciones]

// Captura de datos desde el usuario
arr = list(map(int, input("Ingresa los elementos del arreglo (separados por espacio): ").split()))
posiciones = int(input("Ingresa el número de posiciones para la rotación: "))
direccion = input("Ingresa la dirección de la rotación (izquierda o derecha): ").strip().lower()

// Rotar el arreglo según la dirección
if direccion == "izquierda":
    resultado = rotar_izquierda(arr, posiciones)
elif direccion == "derecha":
    resultado = rotar_derecha(arr, posiciones)
else:
    print("Dirección no válida.")
    resultado = []

// Mostrar el resultado
print(f"El arreglo rotado hacia la {direccion} es: {resultado}")

// Este es un programa en ARM64 que rota los elementos de un arreglo hacia la izquierda o derecha.
*/
.global _start

.section .data
    arr:    .word 1, 2, 3, 4, 5  // Arreglo con los elementos
    size:   .word 5               // Tamaño del arreglo
    posiciones: .word 2           // Número de posiciones para la rotación
    direccion: .word 0            // Dirección de la rotación (0 para izquierda, 1 para derecha)
    temp:   .space 20             // Espacio temporal para almacenar los elementos rotados

.section .bss

.section .text

_start:
    // Cargar la dirección del arreglo y el tamaño
    LDR R0, =arr                // Cargar la dirección del arreglo
    LDR R1, =size               // Cargar la dirección del tamaño
    LDR R1, [R1]                // Cargar el tamaño del arreglo en R1
    LDR R2, =posiciones         // Cargar la dirección de las posiciones
    LDR R2, [R2]                // Cargar el número de posiciones a rotar
    LDR R3, =direccion          // Cargar la dirección de rotación
    LDR R3, [R3]                // Cargar la dirección de rotación (0 para izquierda, 1 para derecha)

    // Verificar si la rotación es a la izquierda (0)
    CMP R3, #0
    BEQ ROTAR_IZQUIERDA         // Si es 0, ir a la rotación izquierda

    // Rotación a la derecha
    B ROTAR_DERECHA

ROTAR_IZQUIERDA:
    // Rotar hacia la izquierda
    // Mover los primeros elementos al final
    LDR R4, =temp              // Cargar la dirección de espacio temporal
    MOV R5, #0                 // Inicializar el índice temporal

    // Guardar los primeros 'posiciones' elementos en la memoria temporal
    MOV R6, #0
    LOOP_LEFT:
        CMP R6, R2             // Comprobar si llegamos al número de posiciones
        BEQ COPY_REST          // Si hemos copiado todos, salimos
        LDR R7, [R0, R6, LSL #2]  // Cargar el valor del arreglo
        STR R7, [R4, R5, LSL #2]  // Guardar en el espacio temporal
        ADD R6, R6, #1         // Incrementar el índice
        ADD R5, R5, #1         // Incrementar el índice temporal
        B LOOP_LEFT            // Continuar el ciclo

    COPY_REST:
        // Copiar el resto del arreglo al principio
        MOV R6, R2
        LDR R5, =arr            // Dirección inicial del arreglo
        LDR R7, [R5, R6, LSL #2]  // Comenzar desde el índice de rotación
        STR R7, [R0, R6, LSL #2]  // Guardar el valor en el arreglo
        ADD R6, R6, #1
        B DONE

ROTAR_DERECHA:
    // Rotar hacia la derecha
    // Guardar los últimos 'posiciones' elementos en la memoria temporal
    MOV R6, R1
    SUB R6, R6, R2             // Comenzar desde el índice de los últimos elementos
    LDR R4, =temp              // Cargar la dirección de espacio temporal
    MOV R5, #0                 // Inicializar el índice temporal
    LOOP_RIGHT:
        CMP R5, R2             // Comprobar si hemos copiado todos
        BEQ COPY_REST_RIGHT    // Si hemos copiado todos, salimos
        LDR R7, [R0, R6, LSL #2]  // Cargar el valor
        STR R7, [R4, R5, LSL #2]  // Guardar en el espacio temporal
        ADD R6, R6, #1         // Incrementar el índice
        ADD R5, R5, #1         // Incrementar el índice temporal
        B LOOP_RIGHT           // Continuar el ciclo

    COPY_REST_RIGHT:
        // Mover los primeros elementos al final
        MOV R6, #0
        LDR R5, =arr
        LDR R7, [R5, R6, LSL #2]  // Comenzar desde el principio
        STR R7, [R0, R6, LSL #2]  // Copiar al arreglo
        ADD R6, R6, #1
        B DONE

DONE:
    // Finalizar el programa
    MOV R7, #1                  // Código de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0
