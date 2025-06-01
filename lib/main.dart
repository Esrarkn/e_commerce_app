import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/ui/auth/bloc/auth_bloc.dart';
import 'package:e_commerce_app/ui/auth/screens/logInPage.dart';
import 'package:e_commerce_app/ui/ecommerce/cubits/cartScreenCubit.dart';
import 'package:e_commerce_app/ui/ecommerce/cubits/detailScreenCubit.dart';
import 'package:e_commerce_app/ui/ecommerce/cubits/homeScreenCubit.dart';
import 'package:e_commerce_app/ui/ecommerce/screens/onBoardingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>CartScreenCubit()),
        BlocProvider(create:(context)=>DetailScreenCubit()),
        BlocProvider(create:(context)=>HomeScreenCubit()),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(FirebaseAuth.instance),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: OnboardingScreen(),
      ),
    );
  }
}