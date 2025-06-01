import 'package:e_commerce_app/ui/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/ui/auth/bloc/auth_event.dart';
import 'package:e_commerce_app/ui/auth/bloc/auth_state.dart';
import 'package:e_commerce_app/ui/auth/screens/logInPage.dart';
import 'package:e_commerce_app/ui/auth/widgets/auth_field.dart';
import 'package:e_commerce_app/ui/auth/widgets/auth_gradient_button.dart';
import 'package:e_commerce_app/ui/tools/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFF4F6F5),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackbar(context, state.message);
              }
              if (state is AuthSuccess) {
                // Başarılı kayıt sonrası yönlendirme
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LogInPage()),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Sign Up.",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      controller: nameController,
                      hintText: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "İsim boş olamaz!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "E-posta adresi boş olamaz!";
                        }
                        String pattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return "Geçerli bir e-posta adresi giriniz!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      controller: passwordController,
                      hintText: "Password",
                      isObscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Şifre en az 6 karakter olmalıdır!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      buttonText: "Sign Up",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Burada AuthSignUp eventini tetikliyorsun
                          context.read<AuthBloc>().add(
                                SignUpEvent(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LogInPage()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
