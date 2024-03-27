import 'package:chat_app/screens/chating_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form.dart';
import '../components/show_snack_bar.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? senderEmailAddress,password;
  GlobalKey<FormState> formKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        color: Colors.white.withOpacity(0.3),
        progressIndicator: const CircularProgressIndicator(
          color: Colors.blue,
        ),
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/chatAnimation.json',
                    width: 300,
                    height: 300,
                    animate: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Chating App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: customTextForm(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      labletext: 'Email',
                      prefix: Icons.email,
                      onChanged: (data) {
                        senderEmailAddress = data;
                      },
                    ),
                  ),
                  customTextForm(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    labletext: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                    prefix: Icons.lock,
                    suffix: isPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: customTextButton(
                      text: 'Sign In',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await LoginUser();
                            Navigator.pushNamed(context, HomeScreen.id,arguments:senderEmailAddress,);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                context,
                                message: 'User not found',
                                backgroundColor: Colors.red,
                              );
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(
                                context,
                                message: 'Wrong password',
                                backgroundColor: Colors.red,
                              );
                            }else{
                              showSnackBar(
                                context,
                                message: e.message.toString(),
                                backgroundColor: Colors.red,
                              );
                            }
                          }catch (e){
                            showSnackBar(
                              context,
                              message: 'An error occurred while login.',
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: kThirdColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: senderEmailAddress!,
      password: password!,
    );
  }
}
