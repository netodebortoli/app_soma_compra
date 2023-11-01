String formatarDateTimeToString(DateTime datatime) {
  String mes;
  mes = datatime.month >= 10
      ? datatime.month.toString()
      : "0${datatime.month.toString()}";
  String dia;
  dia = datatime.day >= 10
      ? datatime.day.toString()
      : "0${datatime.day.toString()}";
  String ano = datatime.year.toString();
  return "$dia/$mes/$ano";
}

DateTime? gerarDateTimeFromString(String data) {
  try {
    if (data.length != 10) {
      // dd/mm/aaaa
      return null;
    }
    String dia = data.substring(0, 2);
    String mes = data.substring(3, 5);
    String ano = data.substring(6);
    String dataFormatada = "$ano-$mes-$dia";
    return DateTime.parse(dataFormatada);
  } on Exception {
    return null;
  }
}
