import 'package:shared_preferences/shared_preferences.dart';




Future<void> writeUserData(userData) async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString("token", userData["token"]);
  await prefs.setString("email", userData["data"]["email"]);



}


Future<String?> readUserData(key) async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();

 String? myData = await prefs.getString(key);
 return myData;


}

Future<bool> removeUserData() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove("token");
  await prefs.remove("email");
  return true;


}


Future<void> writeEmailVerification(email)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("EmailVerification", email);



}

Future<void> writeOTPVerification(otp)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("OTPVerification", otp);



}

