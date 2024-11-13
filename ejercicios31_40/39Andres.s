/* 
Nombre del Programa: DecimalABinarioAndres.py
Descripción: Este programa convierte un número decimal a su equivalente en binario.
Captura de datos: El usuario ingresa un número decimal que será convertido a binario.
Resultado: El programa muestra el número binario correspondiente al valor decimal ingresado.
Ejemplo:
    Entrada:
        Ingresa un número decimal: 10
    Salida:
        El número binario de 10 es: 1010


def decimal_a_binario(decimal):
    if decimal == 0:
        return "0"
    
    binario = ""
    while decimal > 0:
        binario = str(decimal % 2) + binario
        decimal = decimal // 2
    return binario

# Función principal
def main():
    decimal = int(input("Ingresa un número decimal: "))
    binario = decimal_a_binario(decimal)
    print(f"El número binario de {decimal} es: {binario}")

if __name__ == "__main__":
    main()

*/ 



// Este es un programa en ARM64 que convierte un número decimal a binario.

.global _start

.section .data
    mensaje: .asciz "Ingresa un numero decimal: " // Mensaje para pedir el número
    salida: .asciz "El numero binario es: %s\n"   // Mensaje para imprimir el resultado
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

    // Leer el número decimal
    MOV X0, 0              // Descriptor de entrada (stdin)
    LDR X1, =buffer        // Dirección del buffer para almacenar la entrada
    MOV X2, 16             // Limitar la cantidad de caracteres leídos
    MOV X8, 63             // Número de syscall para leer
    SVC 0                  // Realizar la llamada al sistema

    // Convertir el número leído de texto a entero
    LDR X1, =buffer        // Dirección del buffer con el número
    BL str_to_int          // Llamar a la función para convertir de string a entero

    // Llamar a la función para convertir el número decimal a binario
    BL decimal_a_binario

    // Imprimir el resultado
    LDR X0, 1              // Descriptor de salida (stdout)
    LDR X1, =salida        // Dirección del mensaje
    MOV X2, 24             // Longitud del mensaje
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

// Función para convertir decimal a binario
decimal_a_binario:
    MOV X3, X2             // Copiar el valor decimal a X3
    MOV X4, 0              // Inicializar el índice para el binario
    MOV X5, 64             // Reservar espacio para el resultado

decimal_to_bin_loop:
    CMP X3, #0             // Verificar si el número es 0
    BEQ decimal_to_bin_done
    UDIV X6, X3, #2        // Dividir el número por 2
    MUL X7, X6, #2         // Multiplicar para obtener el residuo
    SUB X7, X3, X7         // Obtener el residuo (0 o 1)
    ADD X4, X4, #1         // Incrementar el índice
    STRB W7, [X5, X4]      // Almacenar el residuo en el resultado
    MOV X3, X6             // Actualizar el número a dividir
    B decimal_to_bin_loop  // Continuar el ciclo

decimal_to_bin_done:
    // Imprimir el número binario
    RET
