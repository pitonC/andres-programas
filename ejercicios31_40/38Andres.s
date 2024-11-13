/*
// Nombre del Programa: ColaArregloAndres.py
// Descripción: Este programa implementa una cola utilizando un arreglo.
// Captura de datos: El usuario puede realizar operaciones de encolar y desencolar elementos.
// Resultado: El programa muestra el estado de la cola después de cada operación.
// Ejemplo:
//    Entrada:
//        Ingresa la operación (encolar 10, encolar 20, desencolar): encolar 10
//        Ingresa la operación (encolar 10, encolar 20, desencolar): encolar 20
//        Ingresa la operación (encolar 10, encolar 20, desencolar): desencolar
//    Salida:
//        La cola después de las operaciones es: [20]

class Cola:
    def __init__(self):
        self.cola = []  // Inicializar una lista vacía

    // Método para encolar (agregar) un elemento
    def encolar(self, valor):
        self.cola.append(valor)

    // Método para desencolar (eliminar) un elemento
    def desencolar(self):
        if len(self.cola) > 0:
            return self.cola.pop(0)  // Eliminar el primer elemento
        else:
            return "La cola está vacía"

    // Método para ver el primer elemento de la cola
    def frente(self):
        if len(self.cola) > 0:
            return self.cola[0]
        else:
            return "La cola está vacía"

    // Método para verificar si la cola está vacía
    def esta_vacia(self):
        return len(self.cola) == 0

// Función principal para interactuar con la cola
def main():
    cola = Cola()  // Crear una instancia de la clase Cola

    while True:
        operacion = input("Ingresa la operación (encolar <valor>, desencolar, salir): ").strip()

        if operacion.startswith("encolar"):
            valor = int(operacion.split()[1])
            cola.encolar(valor)
            print(f"La cola después de encolar: {cola.cola}")
        elif operacion == "desencolar":
            resultado = cola.desencolar()
            print(f"Elemento desencolado: {resultado}")
            print(f"La cola después de desencolar: {cola.cola}")
        elif operacion == "salir":
            break
        else:
            print("Operación no válida")

if __name__ == "__main__":
    main()
*/
// Este es un programa en ARM64 que implementa una cola utilizando un arreglo.

.global _start

.section .data
    cola: .space 40             // Espacio para 10 elementos de 4 bytes (40 bytes)
    frente: .word 0             // Índice del frente de la cola
    fin: .word 0                // Índice del final de la cola

.section .bss

.section .text

_start:
    // Función principal para interactuar con la cola
    MOV R1, #0                  // Inicializar el índice del frente de la cola en 0
    MOV R2, #0                  // Inicializar el índice del final de la cola en 0
    MOV R3, cola                // Dirección de la cola

ENCOLAR:
    // Función para encolar (agregar) un valor
    MOV R4, #10                 // El valor a encolar (ejemplo: 10)
    LDR R5, =fin                // Cargar la dirección del final
    LDR R6, [R5]                // Cargar el valor del final de la cola
    STR R4, [R3, R6, LSL #2]    // Guardar el valor en la posición correspondiente del arreglo
    ADD R6, R6, #1              // Incrementar el índice del final
    STR R6, [R5]                // Actualizar el índice del final

    // Ver el contenido de la cola
    LDR R7, =frente             // Cargar la dirección del frente de la cola
    LDR R8, [R7]                // Cargar el índice del frente de la cola
    LDR R9, [R3, R8, LSL #2]    // Cargar el valor en la posición del frente
    MOV R0, R9                  // Mover el valor del frente a R0 para su salida

    // Finalizar el programa
    MOV R7, #1                  // Código de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0

DESENCOLAR:
    // Función para desencolar (eliminar) un valor
    LDR R5, =frente             // Cargar la dirección del frente
    LDR R6, [R5]                // Cargar el valor del frente de la cola
    LDR R7, [R3, R6, LSL #2]    // Cargar el valor en la posición correspondiente del arreglo
    MOV R0, R7                  // Mover el valor desencolado a R0
    ADD R6, R6, #1              // Incrementar el índice del frente
    STR R6, [R5]                // Actualizar el índice del frente

    // Finalizar el programa
    MOV R7, #1                  // Código de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0

