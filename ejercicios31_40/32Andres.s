/*
// Nombre del Programa: PotenciaAndres.py
// Descripción: Este programa calcula la potencia de un número x elevado a n (x^n).
// Captura de datos: Los valores de base (x) y exponente (n) son proporcionados por el usuario.
// Resultado: El programa muestra el resultado de la potencia (x^n).
// Ejemplo:
//    Entrada:
//        Introduce la base (x): 3
//        Introduce el exponente (n): 4
//    Salida:
//        El resultado de 3^4 es: 81

// Función para calcular la potencia de x^n
def potencia(x, n):
    resultado = 1
    for i in range(n):
        resultado *= x
    return resultado

// Captura de datos desde el usuario
base = int(input("Introduce la base (x): "))
exponente = int(input("Introduce el exponente (n): "))

// Calcular la potencia
resultado = potencia(base, exponente)

// Mostrar el resultado
print(f"El resultado de {base}^{exponente} es: {resultado}")

// Este es un programa en ARM64 que calcula la potencia de un número x^n (x elevado a la potencia de n).
*/
.global _start

.section .data
    base:   .word 3         // Base (x)
    exponent: .word 4       // Exponente (n)
    result: .word 1         // Resultado de la potencia (x^n)

.section .bss

.section .text

_start:
    // Cargar la base y el exponente
    LDR R0, =base          // Cargar la base en R0
    LDR R1, [R0]           // Cargar el valor de base en R1
    LDR R0, =exponent      // Cargar el exponente en R0
    LDR R2, [R0]           // Cargar el valor de exponente en R2

    // Inicializar el resultado en 1
    MOV R3, #1             // R3 = 1 (inicializamos el resultado)

    // Verificar si el exponente es 0
    CMP R2, #0
    BEQ DONE                // Si el exponente es 0, la respuesta es 1

    // Calcular la potencia x^n
POWER_LOOP:
    MUL R3, R3, R1         // Multiplicar resultado por la base
    SUB R2, R2, #1         // Decrementar el exponente
    CMP R2, #0             // Verificar si el exponente llegó a 0
    BNE POWER_LOOP         // Si el exponente no es 0, continuar el ciclo

DONE:
    // Guardar el resultado en la memoria
    LDR R0, =result
    STR R3, [R0]           // Guardar el resultado de la potencia en la variable result

    // Imprimir el resultado (simplemente finalizar para evitar colgar el sistema)
    MOV R7, #1             // Sistema de salida
    MOV R0, #0             // Código de salida 0
    SVC #0
