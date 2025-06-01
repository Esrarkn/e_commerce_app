import 'package:e_commerce_app/ui/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/ui/auth/bloc/auth_event.dart';
import 'package:e_commerce_app/ui/auth/bloc/auth_state.dart';
import 'package:e_commerce_app/ui/auth/screens/signUpPage.dart';
import 'package:e_commerce_app/ui/auth/widgets/auth_field.dart';
import 'package:e_commerce_app/ui/auth/widgets/auth_gradient_button.dart';
import 'package:e_commerce_app/ui/ecommerce/screens/homeScreen.dart';
import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
  if (state is AuthFailure) {
    showSnackbar(context, state.message);
  } else if (state is AuthSuccess) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(user: state.user)), 
    );
  }
},

          builder: (context, state) {
            if (state is AuthLoading) {
              Center(
  child: CircularProgressIndicator(),
);
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In.",
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  AuthField(
                    controller: emailController,
                    hintText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  AuthField(
                    controller: passwordController,
                    hintText: "Password",
                    isObscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: "Sign In",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Event gönder: Firebase login
                        context.read<AuthBloc>().add(SignInEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
