# Archivo: mcd.py
# Descripción: Programa en Python que invoca una función ensambladora en ARM64 para calcular el MCD.

import ctypes
import os

# Cargar la biblioteca compartida generada a partir del ensamblador
lib = ctypes.CDLL(os.path.abspath("./libmcd_macro.so"))

# Definir los tipos de argumentos y el tipo de retorno de la función ensambladora
lib.gcd_func.argtypes = [ctypes.c_long, ctypes.c_long]
lib.gcd_func.restype = ctypes.c_long

def main():
    try:
        # Capturar los valores de a y b desde el usuario
        a = int(input("Ingrese el primer número (positivo): "))
        b = int(input("Ingrese el segundo número (positivo): "))

        # Validar que los números sean positivos
        if a <= 0 or b <= 0:
            print("Error: Ambos números deben ser positivos y mayores que cero.")
            return

        # Llamar a la función ensambladora que ejecuta la macro gcd
        result = lib.gcd_func(a, b)

        # Imprimir el resultado
        print(f"El MCD de {a} y {b} es: {result}")
    except ValueError:
        print("Error: Debe ingresar un número entero válido.")

if __name__ == "__main__":
    main()
