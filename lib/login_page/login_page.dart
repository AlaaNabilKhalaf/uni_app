import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import 'package:uni_attendance/generated/l10n.dart';
import '../constance.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    final lang = S.of(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 100.h, bottom: 20.h, left: 35.w, right: 35.w),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Group 538.png',
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          S.of(context).Login,
                          style: const TextStyle(
                              color: primeColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Email
                      Text(
                        lang.UniEmail,
                        style: TextStyle(fontSize: 20.sp, color: primeColor),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        onTap: () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                        controller: cubit.uniEmailController,
                        decoration: InputDecoration(
                            hintText: lang.UniEmailHint,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.w,
                                color: primeColor,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.r),
                                borderSide:
                                    BorderSide(width: 2.w, color: primeColor))),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      // Password
                      Text(
                        lang.LoginPassword,
                        style: TextStyle(fontSize: 20.sp, color: primeColor),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        onTap: () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                        controller: cubit.loginPasswordController,
                        obscureText: cubit.loginPassCheck,
                        decoration: InputDecoration(
                            hintText: lang.LoginPasswordHint,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeLoginPassVisibility();
                              },
                              icon: Icon(
                                cubit.loginPassCheck
                                    ? Icons.remove_red_eye
                                    : Icons.password,
                                color: primeColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.w,
                                color: primeColor,
                              ),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.r),
                                borderSide:
                                    BorderSide(width: 2.w, color: primeColor))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (cubit.loginPasswordController.text.isNotEmpty &&
                        cubit.uniEmailController.text.isNotEmpty)
                    {
                      try{
                        await cubit.login(
                            uniEmail: cubit.uniEmailController.text,
                            password: cubit.loginPasswordController.text);
                      }catch (e) {
                        cubit.loginMassage =lang.SomethingWentWrong;
                      }
                      if (cubit.loginMassage == "Logged in successfully")
                      {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Center(child: Text(cubit.loginMassage!)),
                        ));
                        cubit.navToHomeScreen(context);
                      }
                      else {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Center(child: Text(cubit.loginMassage!)),
                        ));
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(
                            child: Text(
                                lang.LoginValidationMassage)),
                      ));
                    }
                  },
                  color: primeColor,
                  elevation: 8,
                  minWidth: 300.w,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Text(
                    lang.Login,
                    style: TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      cubit.changeLocale();
                    },
                    color: primeColor,
                    elevation: 8,
                    minWidth: 300.w,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Text(
                      lang.LangLab,
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
