import 'package:app_soma_conta/customs_widget/ToastErro.dart';

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

String formatarDateTimeToISOString(DateTime datatime) {
  return datatime.toIso8601String();
}

DateTime gerarDateTimeFromISOString(String data) {
    return DateTime.parse(data);
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

String getMonthByNumber(int number){
  switch(number){
    case 1 || 01: return 'Jan';
    case 2 || 02: return 'Fev';
    case 3 || 03: return 'Mar';
    case 4 || 04: return 'Abr';
    case 5 || 05: return 'Mai';
    case 6 || 06: return 'Jun';
    case 7 || 07: return 'Jul';
    case 8 || 08: return 'Ago';
    case 9 || 09: return 'Set';
    case 10: return 'Out';
    case 11: return 'Nov';
    case 12: return 'Dez';
    default: return '';
  }
}
