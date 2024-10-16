
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;

import '../ui/utils/utils.dart';

var baseUrl = "http://152.42.163.176:2006/api/v1";
var requestHeader = {"Content-Type": "application/json"};


Future<bool> loginRequest(formValues)async{

  var url = Uri.parse("$baseUrl/Login");
  var postBody = json.encode(formValues);
  var response = await http.post(url,body: postBody,headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if(resultCode == 200 && resultBody["status"] == "success"){

    // For token and email store
     await writeUserData(resultBody);

     debugPrint(resultBody.toString());

    debugPrint("Request Success");
    Get.snackbar("Success","Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");

    Get.snackbar("Fail","Request fail : try again!");
    return false;
  }



}

Future<bool> registrationRequest(formValues)async{

  var url = Uri.parse("$baseUrl/Registration");
  var postBody = json.encode(formValues);
  var response = await http.post(url,body: postBody,headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }



}

Future<bool> verifyEmailRequest(email)async{

  var url = Uri.parse("$baseUrl/RecoverVerifyEmail/$email");
  var response = await http.get(url,headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if(resultCode == 200 && resultBody["status"] == "success"){
    await writeEmailVerification(email);

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }



}

Future<bool> verifyOTPRequest(email,otp)async{

  var url = Uri.parse("$baseUrl/RecoverVerifyOtp/$email/$otp");
  var response = await http.get(url,headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if(resultCode == 200 && resultBody["status"] == "success"){
    await writeOTPVerification(otp);

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }



}

Future<bool> setPasswordRequest(formValues)async{

  var url = Uri.parse("$baseUrl/RecoverResetPassword");
  var postBody = json.encode(formValues);
  var response = await http.post(url,body: postBody,headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);

  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }



}




Future<List> taskListRequest(status) async {
  var url = Uri.parse("$baseUrl/listTaskByStatus/$status");
  String? token = await readUserData("token");
  var requestHeaderWithToken = {"Content-Type": "application/json","token":"$token"};
  var response = await http.get(url,headers: requestHeaderWithToken);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return resultBody["data"];
  }else{
    debugPrint("Request fail : try again!");
    return [];
  }
}

Future<bool> taskCreateRequest(formValues) async {
  var url = Uri.parse("$baseUrl/createTask");
  String? token = await readUserData("token");
  var requestHeaderWithToken = {"Content-Type": "application/json","token":"$token"};
  var postBody = json.encode(formValues);
  var response = await http.post(url,headers: requestHeaderWithToken,body: postBody);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }
}

Future<bool> taskDeleteRequest(id) async {
  var url = Uri.parse("$baseUrl/deleteTask/$id");
  String? token = await readUserData("token");
  var requestHeaderWithToken = {"Content-Type": "application/json","token":"$token"};
  var response = await http.get(url,headers: requestHeaderWithToken);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }
}

Future<bool> taskUpdateRequest(id,status) async {
  var url = Uri.parse("$baseUrl/updateTaskStatus/$id/$status");
  String? token = await readUserData("token");
  var requestHeaderWithToken = {"Content-Type": "application/json","token":"$token"};
  var response = await http.get(url,headers: requestHeaderWithToken);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return true;
  }else{
    debugPrint("Request fail : try again!");
    return false;
  }
}

Future<List> taskCountRequest() async {
  var url = Uri.parse("$baseUrl/taskStatusCount");
  String? token = await readUserData("token");
  var requestHeaderWithToken = {"Content-Type": "application/json","token":"$token"};
  var response = await http.get(url,headers: requestHeaderWithToken);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if(resultCode == 200 && resultBody["status"] == "success"){

    debugPrint("Request Success");
    return resultBody["data"];
  }else{
    debugPrint("Request fail : try again!");
    return [];
  }
}