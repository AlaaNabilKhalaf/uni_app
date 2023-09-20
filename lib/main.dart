import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/bloc_observer/bloc_observer.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/splash_screen_cubit/cubits.dart';
import 'package:uni_attendance/splash_screen/splash_screen.dart';
void main() {
  runApp(const MyApp());
  Bloc.observer=MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider<LayoutCubit>(
            create: (context)=> LayoutCubit(),
          ),

          BlocProvider<SplashScreenCubit>(
            create: (context)=> SplashScreenCubit(),
          ),
    ],

      child: ScreenUtilInit(
      designSize: const Size(390,844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child){
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },

    ),);
  }
}

