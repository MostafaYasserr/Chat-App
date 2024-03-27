import 'package:chat_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/custom_text_button.dart';
import '../components/custom_text_form.dart';
import '../components/show_snack_bar.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  static const String id = 'RegistrationScreen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final dbUsers = FirebaseFirestore.instance.collection(kUsersCollections);

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? senderEmailAddress, password, userName;

  GlobalKey<FormState> formKey = GlobalKey();

  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B202D),
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
                    'assets/registration2.json',
                    width: 300,
                    height: 300,
                    animate: false,
                  ),
                  const Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: customTextForm(
                        prefix: Icons.person,
                        labletext: 'Full Name',
                        onChanged: (value) {
                          userName=value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: userNameController,
                    ),
                  ),
                  customTextForm(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onChanged: (data) {
                      senderEmailAddress = data;
                    },
                    labletext: 'Email',
                    prefix: Icons.email,
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
                    onChanged: (data) {
                      password = data;
                    },
                    labletext: 'Password',
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
                      text: 'Register',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await registerUser();
                            showSnackBar(
                              context,
                              message: 'Registration successful.',
                              backgroundColor: Colors.green,
                            );
                            dbUsers.add({
                              kUserName: userName,
                              kEmail: senderEmailAddress,
                              kUid: FirebaseAuth.instance.currentUser!.uid,
                            });
                            Navigator.pushNamed(context, HomeScreen.id,arguments: senderEmailAddress);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(
                                context,
                                message: 'The password provided is too weak.',
                                backgroundColor: Colors.red,
                              );
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(
                                context,
                                message: 'this email is already in use.',
                                backgroundColor: Colors.red,
                              );
                            } else {
                              showSnackBar(
                                context,
                                message: e.code.toString(),
                                backgroundColor: Colors.red,
                              );
                            }
                          } catch (e) {
                            showSnackBar(
                              context,
                              message: 'An error occurred while registering.',
                              backgroundColor: Colors.red,
                            );
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
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

  Future<void> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: senderEmailAddress!,
      password: password!,
    );
  }
}
