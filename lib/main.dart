import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/bloc_observer/bloc_observer.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import 'package:uni_attendance/cubit/splash_screen_cubit/cubits.dart';
import 'package:uni_attendance/local_network/local_network.dart';
import 'package:uni_attendance/splash_screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This Method is controlling the status bar appearance.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    // MultiBlocProvider is the provider of the state management of the code (cubit).
    return MultiBlocProvider(
      providers: [
        BlocProvider<LayoutCubit>(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider<SplashScreenCubit>(
          create: (context) => SplashScreenCubit(),
        ),
      ],

      // ScreenUtilInit is creating the app responsiveness
      child: BlocConsumer<LayoutCubit , LayoutStates>(
        listener: (context , state ){},
        builder: (context , state){
          final cubit = BlocProvider.of<LayoutCubit>(context);
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return  MaterialApp(
                locale: cubit.myCurrentLang,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
              );
            },
          );
        },
      )
    );
  }
}
