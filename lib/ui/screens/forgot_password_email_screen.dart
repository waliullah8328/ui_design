import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_design/ui/screens/forgot_password_otp_screen.dart';
import 'package:ui_design/ui/screens/signin_screen.dart';
import 'package:ui_design/ui/widgets/screen_background.dart';

import '../../api/apiClient.dart';
import '../utils/app_colors.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  Map<String,String> formValues ={"email":"",};
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

    bool response = await verifyEmailRequest(formValues["email"]);
    if(response == true){
      setState(() {
        isLoading = false;
      });
      // Navigate to dashboard screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordOtpScreen(),));
    }
    else{
      setState(() {
        isLoading = false;
      });

    }






  }
  final _forgotEmailFormKey = GlobalKey<FormState>();

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
                  Text("Your Email Address",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 8,),
                  Text("A 6 digit verification otp will be sent to your email address",style: textTheme.titleSmall?.copyWith(color: Colors.grey),),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildVerifyEmailForm(),
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


  Widget _buildVerifyEmailForm() {
    return Form(
      key: _forgotEmailFormKey,
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
    Navigator.pop(context);
  }
  
  void _onTapNextButton(){
    if(!_forgotEmailFormKey.currentState!.validate()){
      return;
    }

    formOnSubmit();
    
  }
}
