/*
Realitza un programa, que mitjançant una funció la qual rep per paràmetres tres valors corresponents a hores, minuts i 
segons en format int, imprimeixi la hora com si fos un rellotge en format: 01:49:11.
Pensa en el range dels valors: 23:59:59, 00:00:00. retorna “InputError” si el inpu no és convertoible a aquest format.
 */

import 'dart:math';

String horaString(int h, int m, int s) {

    // Creamos la variable Duration, para convertir los ints en una hora. 
    var hora = Duration(hours: h, minutes: m, seconds: s);

    //Sacamos las partes individuales de la hora. 
    int hours = hora.inHours;
    int minutes = hora.inMinutes.remainder(60);
    int seconds = hora.inSeconds.remainder(60);
    String formattedTime;
    if (hours > 23 || seconds < 0) {
        formattedTime = "Hora incorrecta"; //Este if controla que la hora proporcionada no sea superior a 23
    } else {
        formattedTime =  '${hours.toString().padLeft(2, '0')}:'     // Damos formato para imprimir la hora (EVITANDO ASI LOS MILISEGUNDOS, que se imprimen por defecto)
                         '${minutes.toString().padLeft(2, '0')}:'   // padLeft se usa para asegurarnos de que son siempre dos digitos
                         '${seconds.toString().padLeft(2, '0')}';
    }

    return formattedTime;
}

String horaString2(int h, int m, int s) {
    String formattedTime = "";
    int hores = h;
    int minuts = m;
    int seg = s;

    if (seg > 59) {
        minuts += (seg/60).toInt();
        seg = seg%60;
    }
    if (minuts > 59) {
        hores += (minuts/60).toInt();
        minuts = minuts%60;
    }
    if (hores > 23) formattedTime = "Hora incorrecta";
    else {
      // padLeft para asegurarme de que los números tengan dos dígitos, aunque sean menores de 10.
        String horesStr = hores.toString().padLeft(2, '0');
        String minutsStr = minuts.toString().padLeft(2, '0');
        String segStr = seg.toString().padLeft(2, '0');
        formattedTime = "$horesStr:$minutsStr:$segStr";
    }


    return formattedTime;
}


void main(List<String> args) {

//Asignación de los valores a los tres INT segund los datos recibidos
int h = int.parse(args[0]);
int m = int.parse(args[1]);
int s = int.parse(args[2]);

// Llamada a la función para convertir los int
print(horaString2(h, m, s));

}