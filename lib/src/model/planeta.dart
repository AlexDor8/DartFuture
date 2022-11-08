import 'package:dart_future/src/model/personaje.dart';

class Planeta {
  late String name;
  late int diameter;
  late String gravity;
  late int population;
  late String climate;
  late List habitantes;

  Planeta(this.name, this.diameter, this.gravity, this.population, this.climate, this.habitantes);


  @override
  String toString() {
    return "Nombre: $name, Diametro: $diameter, Gravedad: $gravity, Poblacion: $population, Clima: $climate, Habitantes: $habitantes";
  }
}