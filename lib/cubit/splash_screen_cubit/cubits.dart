import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_attendance/cubit/splash_screen_cubit/states.dart';
import 'package:uni_attendance/test.dart';
import '../../login_page/login_page.dart';

class SplashScreenCubit extends Cubit <SplashScreenStates>{
  SplashScreenCubit() : super(SplashInitialState());

  delayAndNavigateFun(BuildContext context){
    emit(SplashInitialState());
    Future.delayed(const Duration(seconds:5),(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> const LoginPage()));
    });
    emit(SplashAndNavigateState());
  }

  navigateFun(BuildContext context){
    emit(SplashInitialState());
    Navigator.pushReplacement(context, MaterialPageRoute
      (builder: (context)=> const Test()));
    emit(FastNavState());
  }
}