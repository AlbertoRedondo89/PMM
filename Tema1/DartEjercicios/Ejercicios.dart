import 'dart:io';
import 'dart:math';

void main() {

    // EJERCICIO 1

 List<int> k = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];

for (int i = 0; i < k.length; i++) {
    if (k[i] > 5) print(k[i]);
}


//-------------------------------------------------------------------------
// EJERCICIO 2

  var a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];

  var b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  var A = a.toSet();
  var B = b.toSet();

  print(A.intersection(B));

  Set<int> c = {};  // SET elimina duplicados
  
  
 /* int long;
  if (a.length > b.length) { 
    long = a.length;
  }
  else {
    long = b.length;
  }
  */
  
  for (int i = 0; i < a.length; i++) {
    for (int j = 0; j < b.length; j++) {
      if (a[i] == b[j]) {
        c.add(a[i]);
      }
    }
  }
  
  List<int> d = c.toList();
  for (int i = 0; i < c.length; i++) {
    print(d[i]);
  }

  intersectionSets(a, b) {
      var A = a.toSet();
      var B = b.toSet();

      
  }

//-------------------------------------------------------------------------
// EJERCICIO 3

String prueba = "Cadena de texto palindrómica";

bool esPalindromo(String cadena) {
    String normalizada = cadena.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    int longitud = normalizada.length;

    for (int i = 0; i < longitud~/2; i++) {
        if (normalizada[i] != normalizada[longitud-1-i]) {
            return false;
        }
    }
    return true;

}

print(esPalindromo(prueba));

//-------------------------------------------------------------------------
// EJERCICIO 4

int mayorNumero(int a, int b, int c) {
    int mayor;
    if (a > b) {
        mayor = a;
    } else {
        mayor = b;
    }
    if (c > mayor) {
        mayor = c;
    }
    return mayor;
}

//-------------------------------------------------------------------------
// EJERCICIO 5

List<int> z = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
List<int> x = [];

for (int i = 0; i > z.length; i++) {
  if ((z[i] % 2) == 0) {
    x.add(z[i]);
  }
}

print(x);



//-------------------------------------------------------------------------
//EJERCICIO 6

/*Realitza un programa que generi un nombre aleatori entre 1 i 100, i seguidament comprovi si aquest 
nombre és primer o no. Pots fer servir la llibreria import 'dart:math';
*/ 
var random = Random(100);


//-------------------------------------------------------------------------
//EJERCICIO 7

/*Escriviu un programa (mitjançant funcions!) Que donada una cadena llarga que contingui diverses paraules
 (en format string), torni a imprimir a l'usuari la mateixa cadena, però amb les paraules en ordre invers. Per exemple:
*/ 
devuelveString(String textos) {
  
}


//-------------------------------------------------------------------------
//EJERCICIO 8 !!!!!!!!!!!!!!!!!!

/* 
Escriu un programa que donada una longitud (expressada numericament int), 
generi una contrasenya segura de la longitud esmentada totalment aleatòria amb caràcters alfanumèrics.
*/
int scan_n() {
  int n = 0;
  while (n <= 0) {
    print("Escribe un entero");
    String? input = stdin.readLineSync();
    int? temp = int.tryParse((input == null) ? '' : input); //Condicional ternario
    //int? temp = int.tryParse(input ?? '')!;
    if (temp != null) n = temp;
  }
  return n;
}

int n = scan_n(); //input por pantalla
String contras = "";

while (contras.length <= n) {
  contras += String.fromCharCode(33 + Random().nextInt(94));
}

print("Contraseña: $contras");


//-------------------------------------------------------------------------
//EJERCICIO 9

/* 
Realitza un programa que donat un nombre, pinti una cuadrícula d’aquesta grandària.
*/


//-------------------------------------------------------------------------
//EJERCICIO 10  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/* 
Genera una classe abstracta anomenada “Treballador”. Aquesta classe ha de tenir les següents variables:

id		(és un identificador únic)
nom		(nom complet del treballador)
sou		(sou numèric)
retencio 	(valor de retenció que té assignat el treballador)

Seguidament declara i implementa el mètode imprimirNom(), que imprimeixi el nom de l’empleat.
També declara el mètode souNet(), que imprimeixi el sou net de cada empleat.

Seguidament has de generar dos perfils d’empleats, Administratiu i Comercial.

El perfil Comercial, ha d’afegir a més dues característiques que són:


ventes	(nº de ventes que fa)
comisio	(import que s’emporta per venta un comercial)

Implementa totes aquestes classes. Dintre del mètode “main()” genera dues classes de treballador específic:

maria	=>	Administratiu
aina		=>	Comercial 

Finalment, genera aquests dos treballadors concrets i crida els seus dos respectius mètodes.

*/


//-------------------------------------------------------------------------
//EJERCICIO 11  !!!!!!!!!!!!!!!!!!!!!!!!!!!

/* 
Realitza una funció que retorni un llistat de “n” nombres primers on “n” ens ve donat per paràmetre.
*/




//******************************* */
//APUNTES
/*
String s1 = " ";    para poner  \, hay que ponerla \\ para "  -> \"
Sring s2 = ' ' ;    salto de linea \n

String s3 = 'James' + ' Bond';
s3 += '0' * 2 + '7';

int euros = 50;
String m2 = "Tu tuviese $euros sería menos pobre"

int n = 3;
double x = 1.05;
num a = 2;

print(n is num) -> devuelve true

var a = 7; // var vale para todo, pero una vez asignado no cambia. 
dynamic a = 7; // como el var, pero cambia de un tipo a otro. 

var? a; // Esto es un puntero. Es decir, asigna un espacio en la memoria, aunque no la llene todavía. Es null. Funciona en todo menos en var. 

bool f = true;

if () // Debe ser booleano, no acepta 0 como falso ni frikadas de esas. 

List<dynamic> stuff = [2, true, "pepe", [], null];
List<int> nums = [1,2,3,4]; //igual que : List nums = <int>[1,2,3,4]

var nums = [1,2,3,5];

print(nums.runtimeType);

nums.add(6); // añade un valor
nums.length // longitud 
nums[2] // sera el 3 en este caso

String cosa = "lsdnfñkldfn";
cosa.split(''); // esto crea una lista separando el string por lo que hay entre comillas. Si no hay nada separa cada caracter. 


bool b = false
var lista = [1,2,3, if(b) 4] // Esto pone el elemento si se cumple el if
var lista = [1, for(int i = 1; i < 5; i++) 2*i, 11] // esto crea una lista de 1 al 11, solo con pares

Set <int> parells = {2,3,4,5};
var imparells = {1,3,5,7,9};

print(imparells.runtimeType);

imparells.addAll({,11, 13});

var M = {
    'nom': 'Alberto',
    'id': 1232,
     1: 'daewoo'
  }

Map<int,String> M = {   <---- Asignas el tipo de objeto a cada columna
    0: 'cosa0',
    1: 'cosa2',
    2: 'cosa3',
    3: 'cosa3'
  };

var emote = '\u{1F697}';

*/ 

}