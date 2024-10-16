import 'package:shared_preferences/shared_preferences.dart';




Future<void> writeUserData(userData) async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();


  try {
    if (userData.containsKey("token") && userData["data"] is List && userData["data"].isNotEmpty) {
      var user = userData["data"][0];  // Access the first user in the list

      await prefs.setString("token", userData["token"]);
      await prefs.setString("email", user["email"]);
      await prefs.setString("firstName", user["firstName"]);
      await prefs.setString("lastName", user["lastName"]);
      await prefs.setString("mobile", user["mobile"]);

      print("User data saved successfully.");
    } else {
      print("Invalid user data structure.");
    }
  } catch (e) {
    print("Error writing user data: $e");
  }



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

