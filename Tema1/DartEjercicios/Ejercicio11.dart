/*
Realitza una funció que retorni un llistat de “n” nombres primers on “n” ens ve donat per paràmetre.

print(llista_n_primers(10));

Sortida: [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]


Pots emprar el programa que heu fet a l’apartat 6 per a calcular si un nombre és primer.

*/

void main() {

print(numerosPrimos(56));

}
List<int> numerosPrimos(int n) {
    List<int> lista = [2];
    int calculador = 3;
    bool comp;

    while (lista.length < n) {
      comp = true;
        for (int i = 2; i*i <= calculador; i++) {
            if (calculador % i == 0) {
              comp = false;
              break;
            }
        }
        if (comp) {
          lista.add(calculador);
        }
        calculador+=2;
    }
    return lista;

}