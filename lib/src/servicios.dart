import 'dart:convert';
import 'dart:io';

import 'package:dart_future/src/model/personaje.dart';
import 'package:dart_future/src/model/planeta.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

List<Planeta> listaPlanetas = [];
List<Personaje> listaPersonajes = [];
List<Personaje> listaTodosPersonajes = [];
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
  client.close();
}

Future<int> idPersonaje() async {
  Map personajes = <String, dynamic>{};
  try {
    personajes = jsonDecode(
        await client.read(Uri.parse('https://swapi.dev/api/people/')));
        for (int i = 0;i<personajes.length;i++) {
          Personaje personaje = Personaje.persosnajeNombre(personajes["results"][i]["name"]);
        }
        
  } on Exception catch (e) {
    print(e);
  }
}
