/*
// Nombre del Programa: MCMAndres.py
// Descripción: Este programa calcula el Mínimo Común Múltiplo (MCM) de dos números dados.
// Captura de datos: Los dos números son proporcionados por el usuario a través de la entrada estándar.
// Resultado: El programa muestra el MCM de los dos números.
// Ejemplo:
//    Entrada:
//        Introduce el primer número: 6
//        Introduce el segundo número: 15
//    Salida:
//        El Mínimo Común Múltiplo de 6 y 15 es: 30

// Función para calcular el Máximo Común Divisor (MCD)
def mcd(a, b):
    while b:
        a, b = b, a % b
    return a

// Función para calcular el Mínimo Común Múltiplo (MCM)
def mcm(a, b):
    return abs(a * b) // mcd(a, b)

// Captura de datos desde el usuario
num1 = int(input("Introduce el primer número: "))
num2 = int(input("Introduce el segundo número: "))

// Cálculo del MCM
resultado = mcm(num1, num2)

// Mostrar el resultado
print(f"El Mínimo Común Múltiplo de {num1} y {num2} es: {resultado}")
*/
.global _start

.section .data
    num1:   .word 6         // Primer número
    num2:   .word 15        // Segundo número
    result: .word 0         // Resultado del MCM

.section .bss

.section .text

_start:
    // Cargar los números
    LDR R0, =num1          // Cargar el primer número en R0
    LDR R1, [R0]           // Cargar el valor de num1 en R0
    LDR R0, =num2          // Cargar el segundo número en R0
    LDR R2, [R0]           // Cargar el valor de num2 en R2
    
    // Llamar a la función MCM
    BL MCM

    // Guardar el resultado en la memoria
    LDR R0, =result
    STR R3, [R0]           // Guardar el resultado en la variable result

    // Imprimir el resultado (simplemente finalizar para evitar colgar el sistema)
    MOV R7, #1             // Sistema de salida
    MOV R0, #0             // Código de salida 0
    SVC #0

MCM:
    // Calcular el MCM utilizando el algoritmo de MCD (Máximo Común Divisor)
    // MCM(a, b) = |a * b| / MCD(a, b)

    // Cargar los números en los registros
    MOV R3, R1             // R3 = a
    MOV R4, R2             // R4 = b
    
    // Calcular el MCD (Máximo Común Divisor) usando el algoritmo de Euclides
    MCD_LOOP:
        CMP R3, R4         // Compara a y b
        BEQ MCD_DONE       // Si son iguales, terminamos
        BGT MCD_SWAP       // Si a > b, intercambiamos
        MOV R5, R3         // R5 = a
        MOV R3, R4         // R3 = b
        MOV R4, R5         // R4 = a

    MCD_SWAP:
        SUB R4, R4, R3     // b = b - a
        B MCD_LOOP         // Repetir el ciclo

    MCD_DONE:
        // El MCD está en R3
        MOV R5, R1         // R5 = a
        MUL R3, R3, R2     // MCD(a, b) * b
        SDIV R3, R3, R4    // (a * b) / MCD(a, b)

    RET
