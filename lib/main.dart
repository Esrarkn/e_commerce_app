import 'package:e_commerce_app/ui/cubits/cartScreenCubit.dart';
import 'package:e_commerce_app/ui/cubits/detailScreenCubit.dart';
import 'package:e_commerce_app/ui/cubits/homeScreenCubit.dart';
import 'package:e_commerce_app/ui/screens/onBoardingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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