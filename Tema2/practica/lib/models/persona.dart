class Persona {
  String nom;
  String cognom;
  String dataNaixement;
  String correuElectronic;
  String contrasenya;
  String ?puntuacio;

  Persona({
    required this.nom,
    required this.cognom,
    required this.dataNaixement,
    required this.correuElectronic,
    required this.contrasenya,
    this.puntuacio,
  });
}
