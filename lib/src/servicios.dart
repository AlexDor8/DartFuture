import 'dart:convert';
import 'dart:io';

import 'package:dart_future/src/model/planeta.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

List<Planeta> listaPlanetas = [];

Future<void> planetas() async{
  final client = RetryClient(http.Client());
  Map planetas = <String, dynamic>{};
  try {
    planetas = jsonDecode(await client.read(Uri.parse('https://swapi.dev/api/planets/')));
    
    for (int i = 0;i<5;i++) {
    Planeta planeta = Planeta(planetas["results"][i]["name"], int.parse(planetas["results"][i]["diameter"]), planetas["results"][i]["gravity"], planetas["results"][i]["population"] == "unknown" ? 0 : int.parse(planetas["results"][i]["population"]), planetas["results"][i]["climate"]);
    listaPlanetas.add(planeta);
    }
    
  }finally {
    client.close();
  }
  print(listaPlanetas);
}

int idPlaneta() {
  print("Introduce la id del planeta del que quieras ver la poblacion:");
  for (int i = 0;i<listaPlanetas.length;i++) {
    print("${i+1} -->  ${listaPlanetas[i].name}");
  }
  stdout.writeln("id:");
  int id = int.parse(stdin.readLineSync()!);
  return id; 
}

Future <void> poblacion(int id) async {
  
}