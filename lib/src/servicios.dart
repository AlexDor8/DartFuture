import 'dart:convert';

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