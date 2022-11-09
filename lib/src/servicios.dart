import 'dart:convert';
import 'dart:io';

import 'package:dart_future/src/model/pelicula.dart';
import 'package:dart_future/src/model/personaje.dart';
import 'package:dart_future/src/model/planeta.dart';
import 'package:dart_future/src/model/vehiculo.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

List<Planeta> listaPlanetas = [];
List<Personaje> listaPersonajes = [];
List<Personaje> listaTodosPersonajes = [];
List<Vehiculo> listaVehiculos = [];
List<Pelicula> listaPeliculas = [];
final client = RetryClient(http.Client());

Future<void> planetas() async {
  Map planetas = <String, dynamic>{};
  try {
    planetas = jsonDecode(
        await client.read(Uri.parse('https://swapi.dev/api/planets/')));

    for (int i = 0; i < 5; i++) {
      Planeta planeta = Planeta(
          planetas["results"][i]["name"],
          int.parse(planetas["results"][i]["diameter"]),
          planetas["results"][i]["gravity"],
          planetas["results"][i]["population"] == "unknown"
              ? 0
              : int.parse(planetas["results"][i]["population"]),
          planetas["results"][i]["climate"],
          planetas["results"][i]["residents"]);
      listaPlanetas.add(planeta);
    }
  } on Exception catch (e) {
    print(e);
  }
  print(listaPlanetas);
  idPlaneta(listaPlanetas);
}

void idPlaneta(List<Planeta> listaPlanetas) {
  print("Introduce la id del planeta del que quieras ver la poblacion:");
  for (int i = 0; i < listaPlanetas.length; i++) {
    print("${i + 1} -->  ${listaPlanetas[i].name}");
  }
  stdout.writeln("id:");
  int id = int.parse(stdin.readLineSync()!);
  //return id;
  poblacion(id);
}

Future<void> poblacion(int id) async {
  Map personajes = <String, dynamic>{};
  try {
    for (int i = 0; i < listaPlanetas[id - 1].habitantes.length; i++) {
      personajes = jsonDecode(await client
          .read(Uri.parse('${listaPlanetas[id - 1].habitantes[i]}')));
      Personaje personaje = Personaje(
          personajes["name"],
          int.parse(personajes["height"]),
          personajes["gender"],
          listaPlanetas[id - 1]);
      listaPersonajes.add(personaje);
    }
    print("Habitantes:");
    for (int i = 0; i < listaPersonajes.length; i++) {
      print(listaPersonajes[i].name);
    }
  } on Exception catch (e) {
    print(e);
  }
  idPersonaje();
}

Future<void> idPersonaje() async {
  Map personajes = <String, dynamic>{};
  try {
    personajes = jsonDecode(
        await client.read(Uri.parse('https://swapi.dev/api/people/')));
    print("Elige un personaje para ver la inforación de su planeta:");
    for (int i = 0; i < personajes.length; i++) {
      Personaje personaje = Personaje.persosnajeNombre(
          personajes["results"][i]["name"],
          personajes["results"][i]["homeworld"]);
      listaTodosPersonajes.add(personaje);
      print("${i + 1} -->  ${listaTodosPersonajes[i].name}");
    }
    stdout.writeln("id:");
    int id = int.parse(stdin.readLineSync()!);
    print(
        "Información del planeta del personaje ${listaTodosPersonajes[id - 1].name}");
    informacionPlaneta(id);
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> informacionPlaneta(int id) async {
  Map homeworldMap = <String, dynamic>{};
  try {
    homeworldMap = jsonDecode(
        await client.read(Uri.parse(listaTodosPersonajes[id - 1].homeworld)));
    Planeta planeta = Planeta(
        homeworldMap["name"],
        int.parse(homeworldMap["diameter"]),
        homeworldMap["gravity"],
        homeworldMap["population"] == "unknown"
            ? 0
            : int.parse(homeworldMap["population"]),
        homeworldMap["climate"],
        homeworldMap["residents"]);
    print(planeta);
    idVehiculo();
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> idVehiculo() async {
  Map vehiculos = <String, dynamic>{};
  try {
    print("Elige un vehiculo para obtener las peliculas donde aparece:");
    vehiculos = jsonDecode(
        await client.read(Uri.parse('https://swapi.dev/api/vehicles/')));
    for (int i = 0; i < vehiculos.length; i++) {
      Vehiculo vehiculo = Vehiculo(vehiculos["results"][i]["name"],
          vehiculos["results"][i]["model"], vehiculos["results"][i]["films"]);
      listaVehiculos.add(vehiculo);
      print("${i + 1} --> ${listaVehiculos[i].name}");
    }
    stdout.writeln("id:");
    int id = int.parse(stdin.readLineSync()!);
    print("Peliculas donde aparece:");
    peliculas(id);
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> peliculas(int id) async {
  Map peliculas = <String, dynamic>{};
  try {
    for (int i= 0; i<listaVehiculos[id-1].peliculas.length;i++) {
      peliculas = jsonDecode(
        await client.read(Uri.parse('${listaVehiculos[id-1].peliculas[i]}')));
        Pelicula pelicula = Pelicula(peliculas["title"], peliculas["director"], peliculas["producer"]);
        listaPeliculas.add(pelicula);
    }

    for (int i = 0;i<listaPeliculas.length;i++) {
      print(listaPeliculas[i]);
    }
    
  } on Exception catch (e) {
    print(e);
  }
  client.close();
}
