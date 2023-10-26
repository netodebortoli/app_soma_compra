abstract class Objeto {
  late int id;

  Objeto();

  Objeto.fromMap(Map<String, dynamic> map) {
    id = map["id"];
  }
}
