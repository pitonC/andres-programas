/* 
Nombre del Programa: BinarioADecimalAndres.py
Descripción: Este programa convierte un número binario a su equivalente en decimal.
Captura de datos: El usuario ingresa un número binario que será convertido a decimal.
Resultado: El programa muestra el número decimal correspondiente al valor binario ingresado.
Ejemplo:
    Entrada:
        Ingresa un número binario: 1100
    Salida:
        El número decimal de 1100 es: 12

def binario_a_decimal(binario):
    decimal = 0
    potencia = 0
    while binario > 0:
        decimal += (binario % 10) * (2 ** potencia)
        binario //= 10
        potencia += 1
    return decimal

# Función principal
def main():
    binario = int(input("Ingresa un número binario: "))
    decimal = binario_a_decimal(binario)
    print(f"El número decimal de {binario} es: {decimal}")

if __name__ == "__main__":
    main()

*/ 

// Este es un programa en ARM64 que convierte un número binario a decimal.

.global _start

.section .data
    mensaje: .asciz "Ingresa un numero binario: " // Mensaje para pedir el número
    salida: .asciz "El numero decimal es: %d\n"   // Mensaje para imprimir el resultado
    buffer: .space 64                             // Espacio para almacenar el número binario

.section .bss

.section .text

_start:
    // Imprimir el mensaje de entrada
    MOV X0, 1              // Descriptor de salida (stdout)
    LDR X1, =mensaje       // Dirección del mensaje
    MOV X2, 24             // Longitud del mensaje
    MOV X8, 64             // Número de syscall para escribir
    SVC 0                  // Realizar la llamada al sistema

    // Leer el número binario
    MOV X0, 0              // Descriptor de entrada (stdin)
    LDR X1, =buffer        // Dirección del buffer para almacenar la entrada
    MOV X2, 16             // Limitar la cantidad de caracteres leídos
    MOV X8, 63             // Número de syscall para leer
    SVC 0                  // Realizar la llamada al sistema

    // Convertir el número leído de texto a entero
    LDR X1, =buffer        // Dirección del buffer con el número
    BL str_to_int          // Llamar a la función para convertir de string a entero

    // Llamar a la función para convertir el número binario a decimal
    BL binario_a_decimal

    // Imprimir el resultado
    MOV X0, 1              // Descriptor de salida (stdout)
    MOV X1, X2             // Valor decimal
    LDR X2, =salida        // Dirección del mensaje
    MOV X8, 64             // Número de syscall para escribir
    SVC 0                  // Realizar la llamada al sistema

    // Finalizar el programa
    MOV X8, 93             // Número de syscall para salir
    MOV X0, 0              // Código de salida
    SVC 0                  // Realizar la llamada al sistema

// Función para convertir un string a un entero
str_to_int:
    MOV X2, 0              // Inicializar el resultado a 0
str_to_int_loop:
    LDRB W3, [X1], #1      // Leer un byte del string
    CMP W3, #10            // Comparar con el valor del salto de línea
    BEQ str_to_int_done    // Si es el salto de línea, terminar
    SUB W3, W3, #48        // Convertir de ASCII a valor numérico
    MUL X2, X2, #10        // Multiplicar el resultado por 10
    ADD X2, X2, W3         // Agregar el nuevo dígito al resultado
    B str_to_int_loop      // Continuar leyendo

str_to_int_done:
    RET

// Función para convertir binario a decimal
binario_a_decimal:
    MOV X3, X2             // Copiar el valor binario a X3
    MOV X4, 0              // Inicializar el resultado decimal a 0
    MOV X5, 0              // Potencia de 2

bin_to_dec_loop:
    CMP X3, #0             // Verificar si el número es 0
    BEQ bin_to_dec_done
    AND X6, X3, #1         // Obtener el último dígito binario
    LSL X6, X6, X5         // Multiplicar el dígito por 2^potencia
    ADD X4, X4, X6         // Sumar el valor al resultado decimal
    ADD X5, X5, #1         // Incrementar la potencia
    LSR X3, X3, #1         // Eliminar el último dígito del número binario
    B bin_to_dec_loop      // Continuar el ciclo

bin_to_dec_done:
    MOV X2, X4             // Resultado decimal final en X2
    RET
