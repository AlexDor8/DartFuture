import 'package:dart_future/src/model/planeta.dart';

class Personaje {
  late String name;
  late int height;
  late String gender;
  late Planeta planeta;

  Personaje(this.name, this.height, this.gender, this.planeta);

  Personaje.persosnajeNombre(this.name);

  @override
  String toString() {
    return "Nombre: $name, Altura: $height, Genero: $gender, Planeta: $planeta";
  }
}