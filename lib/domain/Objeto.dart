abstract class Objeto {
  late int id;

  Objeto();

  Objeto.fromMapToEntity(Map<String, dynamic> map) {
    id = map["id"];
  }
}
