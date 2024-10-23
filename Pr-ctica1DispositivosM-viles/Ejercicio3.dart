import 'dart:math';

void main() {

          // Crea dues llistes, una de cotxes i un altre de motos, de 5 posicions cadascun.
    List<Cotxe> cotxes = [];
    List<Moto> motos = [];

          // Mitjançant l’ús dels diferents constructors, crea i inicialitza 5 cotxes i 5 motos i posa’ls dins de cada llista pertinent.
    Cotxe c1 = new Cotxe.vacio();
    Cotxe c2 = new Cotxe.matricula("4332KBB");
    Cotxe c3 = new Cotxe.complet("4354FFF", "Toyota", "Corola", null);
    Cotxe c4 = new Cotxe.matricula("8785EFF");
    Cotxe c5 = new Cotxe.complet("9888BCC", "SEAT", "Ibiza", "43543419C");

    Moto m1 = new Moto.vacio();
    Moto m2 = new Moto.complet("3998DAW", "Yamaha", "VR9", "44455598A", 90);
    Moto m3 = new Moto.matricula("4443DDD");
    Moto m4 = new Moto.matricula("W3321ED");
    Moto m5 = new Moto.complet("4556VCD", "Suzuki", "XR7", null, 70);

    cotxes.addAll([c1, c2, c3, c4, c5]);
    motos.addAll([m1, m2, m3, m4, m5]);

          // Crea un o varis clients per a que “lloguin” uns vehicles.
    Client cli1 = new Client.Simple("4334233D", "Alfredo García");
    Client cli2 = new Client.Completo("98757756C", "Marta Fernandez", "marta@gmail.com", 988954459, 546637728839485812);
    Client cli3 = new Client.Completo("98455432R", "Rosa", "rosa@gmail.com", 988432321, 98769435323495768);

          // Realitza el “lliurament” d’alguns cotxes i motos amb el mètode llogar() als clients creats.
    c3.llogat(cli3.dni);
    print(c3);
    c3.retornat();
    print(c3);
          //----
    print(m2);
    m2.llogat(cli2.dni);
    print(m2);
    m2.retornat();
    print(m2);
          //----  Acceso al coche mediante la lista
    cotxes.elementAt(3).llogat(cli2.dni);
    print(cotxes.elementAt(3));

          // Compta quants cotxes i motos hi llogats i digues quants n’hi ha en total.
    int vehiclesTotals = cotxes.length + motos.length;
    int llogats = 0;
    for (var c in cotxes) if (c.estaLlogat()) llogats += 1;
    for (var m  in motos) if (m.estaLlogat()) llogats += 1;
  
    print("Actualmente hi ha $llogats vehicles llogats d'un total de $vehiclesTotals.");

          // Finalment, indica el cotxe que té més quilòmetres i la moto amb més quilòmetres. Mostra'ls per pantalla amb tota la seva informació (fés servir el mètode toString ()).
          // Primero asignaré km aleatorios a cada vehículo, para evitar que estén todos a 0
    Random rndm = Random();
    for (var c in cotxes) {
      int km = rndm.nextInt(20000);
      c.sumaKm(km);
    }
    for (var m in motos) {
      int km = rndm.nextInt(20000);
      m.sumaKm(km);
    }
          //Comparación de km
    Cotxe maxKmCotxe = new Cotxe.vacio();
    if (cotxes.isNotEmpty) {
      maxKmCotxe = cotxes[0];                            // Igualamos el coche de prueba al primero de la lista
      for (int i = 1; i < cotxes.length; i++) {
        if (maxKmCotxe.compareTo(cotxes[i])! < 0) {   // Vamos comparando el coche de prueba con el resto, sustituyéndolo por el que le supere en km
          maxKmCotxe = cotxes[i];
        }
      }
    }
    Moto maxKmMoto = new Moto.vacio();
    if (motos.isNotEmpty) {
      maxKmMoto = motos[0];
      for (int i = 1; i < motos.length; i++) {
        if (maxKmMoto.compareTo(motos[i])! < 0) {
          maxKmMoto = motos[i];
        }
      }
    }
    print("-------------------------------------------");
    print("El cotxe amb més km es: " + maxKmCotxe.toString());
    print("-------------------------------------------");
    print("La moto amb més km es: " + maxKmMoto.toString());

}

// ----------------------------------------------------------
// -------------------------------------------------  CLIENTE

class Client {

  String _dni;
  String _nom;
  String? _email;
  int? _telefon;
  int? _tarjeta;

 Client.Simple(this._dni, this._nom) {}
 Client.Completo(this._dni, this._nom, this._email, this._telefon, this._tarjeta) {}

//SETTERS
set dni(String dni) {
  _dni = dni;
}
set nom(String nom) {
  _nom = nom;
}

set email(String? email) {
  _email = email;
}

set telefon(int? telefon) {
  _telefon = telefon;
}

set tarjeta(int? tarjeta) {
  _tarjeta = tarjeta;
}

//GETTERS
String get dni => _dni;
String get nom => nom;
String? get email => _email; 
int? get telefon => _telefon;
int? get tarjeta => _tarjeta;


// SOBREESCRITURA DE toString()
  @override
  String toString() {
    return 'Client(dni: $_dni,\n nom: $_nom,\n email: ${_email ?? "Sin email"},\n '
           'telefon: ${_telefon ?? "No disponible"},\n tarjeta: ${_tarjeta ?? "No disponible"})';
  }

}


// ----------------------------------------------------------
// ------------------------------------------------  VEHICULO

abstract class Vehicle {

String? _matricula;
String? _marca;
String? _model;
bool _llogat = false;
String? _dniClient;
int _km = 0;

Vehicle.vacio(){}
Vehicle.matricula(this._matricula) {}
Vehicle.complet(this._matricula, this._marca, this._model, this._dniClient){}

//SETTERS
set matricula(String? matricula){
  _matricula = matricula;
}
set marca(String? marca) {
  _marca = marca;
}
set model(String? model) {
  _model = model;
}
set client(String? dniClient) {
  _dniClient = dniClient;
}

//GETTERS
String? get matricula => _matricula;
String? get marca => _marca;
String? get model => _model;
String? get client => _dniClient;
int get km => _km;


//Metodos adicionales
llogat(String dni) {
  _dniClient = dni;
  _llogat = true;
}

retornat() {
  _dniClient = null;
  _llogat = false;
}
bool estaLlogat() => _llogat;
sumaKm(int km) => _km += km;
int? compareTo(Object a) {
  // Compara el objeto recibido con el otro y devuelve la diferencia de km si son del mismo tipo (Cotxe/moto)
  if (a is Cotxe && this is Cotxe) {
    Cotxe otroCotxe = a;
    return this._km.compareTo(otroCotxe._km);
  } else if (a is Moto && this is Moto) {
    Moto otraMoto = a;
    return this._km.compareTo(otraMoto._km);
  } else {
    print("No es posible comparar vehícles de diferent tipus.");
    return null;
  }
}


// SOBREESCRITURA DE toString()
// Añadida una condición que comprueba si está alquilado y, si lo está, añade el dni del cliente. 
  @override
String toString() {
  String data = 'Vehicle --- Matricula: ${_matricula ?? "Matrícula no asignada"},\n'
          'Marca: ${_marca ?? "Marca no asignada"},\n Model: ${_model ?? "Model no asignat"},\n'
          'Está llogat: ${_llogat ?? "no"},\n Km: $_km\n';
          if (_llogat) data += ' DNI Client: $_dniClient';
  return data;
}

}




// ----------------------------------------------------------
// ---------------------------------------------------  COTXE

class Cotxe extends Vehicle {

    Cotxe.vacio(): super.vacio() {}
    Cotxe.matricula(String matricula): super.matricula(matricula) {}
    Cotxe.complet(String matricula, String marca, String model, String? dniClient): super.complet(matricula, marca, model, dniClient){
      if(dniClient != null) _llogat = true; //Al incluirse un DNI, se entiende que el vehículo está alquilado. 
    }

}



// ----------------------------------------------------------
// ----------------------------------------------------  MOTO

class Moto extends Vehicle {

  int? _cilindrada;

  Moto.vacio():super.vacio() {}
  Moto.matricula(String matricula):super.matricula(matricula){}
  Moto.complet(String matricula, String marca, String model, String? dniClient, this._cilindrada):super.complet(matricula, marca, model, dniClient){
     if(dniClient != null ) _llogat = true;
  }

  int? get cilindrada => _cilindrada;
  set cilindrada(int? cil) {
    _cilindrada = cil;
  }
}