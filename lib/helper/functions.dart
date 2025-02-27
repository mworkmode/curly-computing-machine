
import 'package:intl/intl.dart';

bool isValidEmail(email)
{
  // return RegExp(r"^([a-zA-Z0-9._+-]+)(@[a-zA-Z0-9-]+)(.[a-zA-Z]{2,4}){2,}$").hasMatch(email) ;
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) ;

}

bool isValidPassword(String value){
  // String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String  pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&#]{8,}$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

String formatAmount(double amount) {
  var formatter = NumberFormat(amount == 0 ? '#,##,###' : '#,##,###.00');
  return formatter.format(amount);
}