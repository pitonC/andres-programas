// Archivo: mcd_macro.s
// Descripción: Implementación de la macro MCD para ARM64 en Raspbian OS

.macro gcd a, b
gcd_\@:
    cmp \a, \b         // Comparar a y b
    b.eq end_\@        // Si son iguales, terminar

    b.gt greater_\@    // Si a > b, ir a greater_\@
    sub \b, \b, \a     // Si a < b, restar a de b
    b gcd_\@           // Repetir el ciclo

greater_\@:
    sub \a, \a, \b     // Si a > b, restar b de a
    b gcd_\@           // Repetir el ciclo

end_\@:
.endm

// Función en ensamblador que calcula el MCD
// Se compilará y se llamará desde C
.text
.globl gcd_func
.type gcd_func, %function
gcd_func:
    // Argumentos en X0 y X1
    // X0 = a, X1 = b
    gcd x0, x1         // Llamar a la macro gcd con los argumentos en X0 y X1
    ret                // Retornar el resultado en X0

