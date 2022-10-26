class Planeta {
  late String name;
  late int diameter;
  late String gravity;
  late int population;
  late String climate;

  Planeta(this.name, this.diameter, this.gravity, this.population, this.climate);


  @override
  String toString() {
    return "Nombre: $name, Diametro: $diameter, Gravedad: $gravity, Poblacion: $population, Clima: $climate";
  }
}