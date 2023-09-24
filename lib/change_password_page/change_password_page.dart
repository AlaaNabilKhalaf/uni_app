import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import 'package:uni_attendance/login_page/login_page.dart';
import '../constance.dart';
import '../generated/l10n.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        final lang = S.of(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 95.h, bottom: 20.h, right: 35.w, left: 35.w),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Group 538.png',
                          fit: BoxFit.fill,
                        ),
                        Text(
                          lang.ResetPassword,
                          style: TextStyle(
                              color: primeColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Email

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          lang.OldPassword,
                          style: TextStyle(fontSize: 20.sp, color: primeColor),
                        ),
                      ),

                      TextFormField(
                        controller: cubit.oldPassController,
                        obscureText: cubit.oldPassCheck,
                        decoration: InputDecoration(
                            label: Text(
                              lang.OldPasswordHint,
                              style: const TextStyle(color: primeColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeOldPassCheckVisibility();
                              },
                              icon: Icon(
                                cubit.oldPassCheck
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
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(width: 2.w, color: primeColor))),
                      ),

                      // Password

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          lang.NewPassword,
                          style: TextStyle(fontSize: 20.sp, color: primeColor),
                        ),
                      ),

                      TextFormField(
                        controller: cubit.newPassController,
                        obscureText: cubit.newPassCheck,
                        decoration: InputDecoration(
                            label: Text(
                              lang.NewPasswordHint,
                              style: const TextStyle(color: primeColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeNewPassCheckVisibility();
                              },
                              icon: Icon(
                                cubit.newPassCheck
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
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(width: 2.w, color: primeColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          lang.ConNewPassWord,
                          style: TextStyle(fontSize: 20.sp, color: primeColor),
                        ),
                      ),

                      TextFormField(
                        controller: cubit.newPassConController,
                        obscureText: cubit.conPassCheck,
                        decoration: InputDecoration(
                            label: Text(
                              lang.NewPasswordHint,
                              style: const TextStyle(color: primeColor),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeConPassCheckVisibility();
                              },
                              icon: Icon(
                                cubit.conPassCheck
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
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(width: 2.w, color: primeColor))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (cubit.oldPassController.text.isEmpty ||
                          cubit.newPassController.text.isEmpty ||
                          cubit.newPassConController.text.isEmpty) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                          duration: const Duration(seconds: 3),
                          content:
                          Center(child: Text(lang.AllFieldsRequired)),
                        ));
                      } else if (cubit.newPassController.text !=
                          cubit.newPassConController.text) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar( SnackBar(
                          duration: const Duration(seconds: 3),
                          content: Center(
                              child: Text(lang.NewPasswordsDoNotMatch)),
                        ));
                      } else if (cubit.newPassController.text ==
                          cubit.newPassConController.text &&
                          cubit.oldPassController.text.isNotEmpty) {
                        try{
                          await cubit.resetPassword(
                              oldPassword: cubit.oldPassController.text,
                              newPassword: cubit.newPassController.text);
                        }catch (e) {
                          cubit.passMassage = lang.SomethingWentWrong;
                        }
                        if (cubit.passMassage == "password has been changed") {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: lang.DONE,
                            desc: cubit.passMassage,
                            buttons: [
                              DialogButton(
                                color: primeColor,
                                onPressed: () => Navigator.pop(context),
                                width: 125.w,
                                child: Text(
                                  lang.OK,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.sp),
                                ),
                              )
                            ],
                          ).show();
                        } else {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: lang.OPS,
                            desc: cubit.passMassage,
                            buttons: [
                              DialogButton(
                                color: primeColor,
                                onPressed: () => Navigator.pop(context),
                                width: 125.w,
                                child: Text(
                                  lang.OK,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.sp),
                                ),
                              )
                            ],
                          ).show();
                        }
                      }
                    },
                    color: primeColor,
                    elevation: 15,
                    minWidth: 300.w,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Text(
                      lang.ResetPassword,
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        cubit.loginPasswordController.text.isEmpty;
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      color: primeColor,
                      elevation: 8,
                      minWidth: 300.w,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w)),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Text(
                        lang.GoToLogin,
                        style: TextStyle(color: Colors.white, fontSize: 25.sp),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
