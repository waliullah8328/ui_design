import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ui_design/ui/screens/signin_screen.dart';
import 'package:ui_design/ui/widgets/screen_background.dart';

import '../../api/apiClient.dart';
import '../utils/app_colors.dart';
import 'main_bottom_nav_bar_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Map<String,String> formValues ={"email":"", "password":"","firstName":"","lastName":"","mobile":"",};
  bool isLoading = false;

  inputOnChange(mapKey, textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });

  }

  formOnSubmit()async{


      setState(() {
        isLoading = true;
      });

      bool response = await registrationRequest(formValues);
      if(response == true){
        setState(() {
          isLoading = false;
        });
        // Navigate to dashboard screen
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen(),), (route) => false);
      }
      else{
        setState(() {
          isLoading = false;
        });

      }






  }
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 82,),
                  Text("Join With Us",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildSignUpForm(),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: _buildHaveAccountSection(),
                  ),



                ],),
            ),
          )),
    );
  }


  Widget _buildSignUpForm() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Email is required";
              }
              return null;
            },
            onChanged: (textValue){
              inputOnChange("email", textValue);
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "First Name is required";
              }
              return null;
            },
            onChanged: (textValue){
              inputOnChange("firstName", textValue);
            },
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(hintText: "First Name"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Last Name is required";
              }
              return null;
            },
            onChanged: (textValue){
              inputOnChange("lastName", textValue);
            },
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(hintText: "Last Name"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Mobile Number is required";
              }
              if(value!.length != 11){
                return "Number should be 11 digits (01*********)";

              }
              return null;
            },
            onChanged: (textValue){
              inputOnChange("mobile", textValue);
            },
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "Mobile Number"),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Password is required";

              }
              if(value!.length <= 6){
                return "Password should be 6 character";
              }
              return null;
            },

            obscureText: true,
            onChanged: (textValue){
              inputOnChange("password", textValue);
            },

            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined)),
        ],
      ),
    );
  }
  Widget _buildHaveAccountSection() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.5),
            text: "Have account? ",
            children: [
              TextSpan(
                  text: "Sign In",
                  style: const TextStyle(color: AppColors.themeColor),
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn)
            ]));
  }
  void _onTapSignIn() {
    // TODO: implement on tap signup screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ));
  }

  void _onTapNextButton() {

    if(!_signUpFormKey.currentState!.validate()){
      return;
    }
    formOnSubmit();
  }
}
