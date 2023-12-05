abstract class Objeto {
  late int id;

  Objeto();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Objeto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Objeto.fromMapToEntity(Map<String, dynamic> map) {
    id = map["id"];
  }
}
