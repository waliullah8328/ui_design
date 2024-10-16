import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/forgot_password_otp_screen.dart';
import 'package:ui_design/ui/screens/signin_screen.dart';
import 'package:ui_design/ui/utils/utils.dart';
import 'package:ui_design/ui/widgets/screen_background.dart';

import '../../api/apiClient.dart';
import '../utils/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Map<String,String> formValues ={"email":"", "OTP": "", "password":""};
  bool isLoading = false;

  inputOnChange(mapKey, textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });

  }

  formOnSubmit() async {
    setState(() {
      isLoading = true;
    });

    bool response = await setPasswordRequest(formValues);

    // Check if the widget is still mounted before calling setState
    if (!mounted) return;

    if (response == true) {
      setState(() {
        isLoading = false;
      });
      // Navigate to the sign-in screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
      );
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  final _resetPasswordFormKey = GlobalKey<FormState>();

  callStoreData() async {
    String? OTP = await  readUserData("OTPVerification");
    String? email = await  readUserData("EmailVerification");

    inputOnChange("OTP",OTP);
    inputOnChange("email",email);
  }

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
                  Text("Set Password",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 8,),
                  Text("Minimum number of password should be 8 character",style: textTheme.titleSmall?.copyWith(color: Colors.grey),),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildResetPasswordForm(),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: _buildHaveAccountSection(),
                  ),



                ],),
            ),
          )),
    );
  }


  Widget _buildResetPasswordForm() {
    return Form(
      key: _resetPasswordFormKey,
      child: Column(
        children: [
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


            onChanged: (textValue){
              inputOnChange("password", textValue);
            },

            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Password"),
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


            onChanged: (textValue){
              inputOnChange("password", textValue);
            },

            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Confirm Password"),
          ),

          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed:_onTapNextButton,
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false);
  }

  void _onTapNextButton(){
    if(!_resetPasswordFormKey.currentState!.validate()){
      return;
    }
    formOnSubmit();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false);

  }
}
