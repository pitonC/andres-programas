/*
// Nombre del Programa: PilaArregloAndres.py
// Descripción: Este programa implementa una pila utilizando un arreglo.
// Captura de datos: El usuario puede realizar operaciones de apilar y desapilar elementos.
// Resultado: El programa muestra el estado de la pila después de cada operación.
// Ejemplo:
//    Entrada:
//        Ingresa la operación (apilar 10, apilar 20, desapilar): apilar 10
//        Ingresa la operación (apilar 10, apilar 20, desapilar): apilar 20
//        Ingresa la operación (apilar 10, apilar 20, desapilar): desapilar
//    Salida:
//        La pila después de las operaciones es: [10]

class Pila:
    def __init__(self):
        self.pila = []  // Inicializar una lista vacía

    // Método para apilar (agregar) un elemento
    def apilar(self, valor):
        self.pila.append(valor)

    // Método para desapilar (eliminar) un elemento
    def desapilar(self):
        if len(self.pila) > 0:
            return self.pila.pop()
        else:
            return "La pila está vacía"

    // Método para ver el elemento superior de la pila
    def cima(self):
        if len(self.pila) > 0:
            return self.pila[-1]
        else:
            return "La pila está vacía"

    // Método para verificar si la pila está vacía
    def esta_vacia(self):
        return len(self.pila) == 0

// Función principal para interactuar con la pila
def main():
    pila = Pila()  // Crear una instancia de la clase Pila

    while True:
        operacion = input("Ingresa la operación (apilar <valor>, desapilar, salir): ").strip()

        if operacion.startswith("apilar"):
            valor = int(operacion.split()[1])
            pila.apilar(valor)
            print(f"La pila después de apilar: {pila.pila}")
        elif operacion == "desapilar":
            resultado = pila.desapilar()
            print(f"Elemento desapilado: {resultado}")
            print(f"La pila después de desapilar: {pila.pila}")
        elif operacion == "salir":
            break
        else:
            print("Operación no válida")

if __name__ == "__main__":
    main()

// Este es un programa en ARM64 que implementa una pila utilizando un arreglo.
*/
.global _start

.section .data
    pila: .space 40             // Espacio para 10 elementos de 4 bytes (40 bytes)
    tope: .word 0              // Índice del tope de la pila

.section .bss

.section .text

_start:
    // Función principal para interactuar con la pila
    MOV R1, #0                  // Inicializar el índice del tope de la pila en 0
    MOV R2, pila                // Dirección de la pila

PUSH:
    // Función para apilar (agregar) un valor
    MOV R3, #10                 // El valor a apilar (ejemplo: 10)
    LDR R4, =tope               // Cargar la dirección del tope
    LDR R5, [R4]                // Cargar el valor del tope (índice)
    STR R3, [R2, R5, LSL #2]    // Guardar el valor en la posición del arreglo correspondiente
    ADD R5, R5, #1              // Incrementar el índice del tope
    STR R5, [R4]                // Actualizar el índice del tope

    // Ver el contenido de la pila
    MOV R6, [R4]                // Cargar el índice del tope
    SUB R6, R6, #1              // Ver el elemento superior de la pila
    LDR R7, [R2, R6, LSL #2]    // Cargar el valor en la posición del tope-1
    MOV R0, R7                  // Mover el valor del tope a R0 para su salida

    // Finalizar el programa
    MOV R7, #1                  // Código de salida
    MOV R0, #0                  // Código de salida 0
    SVC #0
