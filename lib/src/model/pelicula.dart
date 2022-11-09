class Pelicula {
  late String titulo;
  late String director;
  late String productor;

  Pelicula(this.titulo, this.director, this.productor);

  @override
  String toString() {
    return "Titulo: $titulo, Director: $director, Productor/es: $productor";
  }
}