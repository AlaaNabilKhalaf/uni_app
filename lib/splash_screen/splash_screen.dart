import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_attendance/cubit/splash_screen_cubit/cubits.dart';
import 'package:uni_attendance/cubit/splash_screen_cubit/states.dart';
import '../constance.dart';
import '../login_page/login_page.dart';

// This Cubit is for  Splash Screen only

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){

      Future.delayed(const Duration(seconds:5),(){
        // SchedulerBinding.instance.addPostFrameCallback((_) {

        // });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=> const LoginPage()));


      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SplashScreenCubit>(context);
    return  BlocConsumer<SplashScreenCubit , SplashScreenStates>(
      listener: (context , state ){},
      builder: (context , state){
        return  GestureDetector(
          onTap: (){
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            // });
            cubit.navigateFun(context);
          },
          child: Scaffold(
            backgroundColor: primeColor,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/splash2.png",),
                      fit: BoxFit.fill)
              ),

            ),
          ),
        );
      },

    );
  }
}
