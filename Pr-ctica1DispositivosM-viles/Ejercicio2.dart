/*
Genera un programa que mostri tots els nombre primers fins a un nombre donat per paràmetre. 
Seguidament, a partir d’aquests nombres primers, mostra una llista de parelles de nombres 
primers la diferència entre els quals sigui de dos. Per exemple:
 */


void main(List<String> args) {

//Verifica que se se da un valor de entrada
if (args.isEmpty) {
    print("Por favor, proporciona un número.");
    return;
  }

//Se parsea el valor a entero. No compruebo si no es un número porque el usuario es buena gente y no hace esas cosas.
int n = int.tryParse(args[0]) ?? -1;

//Compruebo que sea mayor a 0, para evitar los números negativos. 
if (n <= 0) {
    print("Por favor, proporciona un número entero positivo.");
    return;
  }

//Llamo a las funciones. Primero genero la lista de enteros y después la de parejas. 
print("Lista de enteros");
List<int> lista = (numerosPrimos(n));
print(lista);
print("Lista de parejas");
List<String> parejas = parejasPrimas(lista);

//Comprobación por si la lista de parejas queda vacía
if (parejas.isEmpty) print("No se encontraron parejas compatibles");
else print(parejas);

}
List<int> numerosPrimos(int n) {
    List<int> lista = [2];
    int calculador = 3;
    bool esPrimo;

    while (lista.length < n) {
      esPrimo = true;
        for (int i = 2; i*i <= calculador; i++) {
            if (calculador % i == 0) {
              esPrimo = false;
              break;
            }
        }
        if (esPrimo) {
          lista.add(calculador);
        }
        calculador+=2;
    }
    return lista;
}


List<String> parejasPrimas(List<int> lista) {

  List<String> listaDevuelta = [];
  String texto = "";

  for (int i = 0; i < lista.length-1; i++) {
    if (lista[i]+2 == lista[i+1]) {
      texto = lista[i].toString() + " i " + lista[i+1].toString();
      listaDevuelta.add(texto);
    } 
  }

  return listaDevuelta;
}