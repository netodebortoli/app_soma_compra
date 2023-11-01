import 'package:intl/intl.dart';

String formatarDateTimeToString(DateTime datetime) {
  // return DateFormat('dd/MM/yyyy').format(data);
  String mes;
  if (datetime.month >= 10)
    mes = datetime.month.toString();
  else
    mes = "0${datetime.month.toString()}";
  String dia;
  if (datetime.day >= 10)
    dia = datetime.day.toString();
  else
    dia = "0${datetime.day.toString()}";
  String ano = datetime.year.toString();
  String data = "$dia/$mes/$ano";
  return data;
}
