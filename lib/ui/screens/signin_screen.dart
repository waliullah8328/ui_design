import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ui_design/api/apiClient.dart';
import 'package:ui_design/ui/screens/forgot_password_email_screen.dart';
import 'package:ui_design/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:ui_design/ui/screens/signup_screen.dart';

import '../utils/app_colors.dart';
import '../widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  Map<String,String> formValues ={"email":"", "password":""};
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

      bool response = await loginRequest(formValues);
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
  final _loginFormKey = GlobalKey<FormState>();



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
                const SizedBox(
                  height: 82,
                ),
                Text(
                  "Get Started With",
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSignInForm(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          )),
                      _buildSignUpSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
  Widget _buildSignInForm() {
    return Form(
      key:_loginFormKey,
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
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
            onChanged: (textValue){
              inputOnChange("email", textValue);
            },
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

            decoration: const InputDecoration(hintText: "Password"),
            onChanged: (textValue){
              inputOnChange("password", textValue);
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: _onTapNextButton,
              child: isLoading? const Center(child: CircularProgressIndicator()): const Icon(Icons.arrow_circle_right_outlined)),
        ],
      ),
    );
  }


  Widget _buildSignUpSection() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.5),
            text: "Don't have an account? ",
            children: [
          TextSpan(
              text: "Sign Up",
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp)
        ]));
  }



  void _onTapNextButton() {
    // TODO: implement on tap next screen
    if(!_loginFormKey.currentState!.validate()){
      return;

    }
    formOnSubmit();

   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen(),), (route) => false);

  }
  void _onTapForgotPasswordButton() {
    // TODO: implement on tap forgot password
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordEmailScreen(),));
  }
  void _onTapSignUp() {
    // TODO: implement on tap signup screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
  }
}
