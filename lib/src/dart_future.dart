/// Support for doing something awesome.
///
/// More dartdocs go here.
library dart_future;

import 'servicios.dart';

export 'dart_future_base.dart';

// TODO: Export any libraries intended for clients of this package.

/**
 * 1. Para hacer una petición asincrona a un servidor, le indicamos la url que corresponda con ese servidor. 
 * Al ser asíncrono, el programa continuará ejecutandose al mismo tiempo. En el caso de qué queramos que nuestro 
 * programa espere a que se realice esa petición utilizaremos la palabra reservada await
 */

void main(List<String> args) async {
  await planetas();
}
