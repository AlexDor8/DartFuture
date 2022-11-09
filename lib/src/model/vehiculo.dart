class Vehiculo {
  late String name;
  late String modelo;
  late List peliculas;

  Vehiculo(this.name,this.modelo, this.peliculas);

  Vehiculo.vehiculoNombre(this.name);

  @override
  String toString() {
    return "Name: $name, Modelo: $modelo, Peliculas: $peliculas";
  }
}