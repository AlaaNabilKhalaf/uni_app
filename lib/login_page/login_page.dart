import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import 'package:uni_attendance/home_page/home_page.dart';
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

    return  BlocConsumer<LayoutCubit , LayoutStates>(
        listener: (context , state ){},
        builder: (context , state ){
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget> [
              Container(
                padding:  EdgeInsets.only(
                    top: 100.h,
                    bottom: 20.h,
                    left: 35.w,
                    right: 35.w
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget> [
                      Image.asset('assets/images/Group 538.png',
                        fit: BoxFit.fill,),
                      SizedBox(height: 15.h,),
                      Image.asset('assets/icons/Login.png',fit: BoxFit.fill,),
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
                    Text('University Email',
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: primeColor
                      ),),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      onTap: (){
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                      controller: cubit.uniEmailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.w,
                              color: primeColor,
                            ),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),

                              borderSide: BorderSide(
                                  width: 2.w,
                                  color: primeColor
                              )
                          )
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    // Password
                    Text('Password',
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: primeColor
                      ),),
                    SizedBox(height: 5.h,),
                    TextFormField(
                      onTap: (){
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                      controller: cubit.loginPasswordController,
                      obscureText: cubit.loginPassCheck,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: (){
                              cubit.changeLoginPassVisibility();
                            },
                            icon:  Icon(
                              cubit.loginPassCheck ?
                              Icons.remove_red_eye :
                              Icons.password,
                              color: primeColor,
                            ),),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.w,
                              color: primeColor,
                            ),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide:  BorderSide(
                                  width: 2.w,
                                  color: primeColor
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              MaterialButton(
                onPressed: () async {

                  if(cubit.uniEmailController.text == "alaa" && cubit.loginPasswordController.text == "555" )

                  {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    cubit.oldPassword = cubit.loginPasswordController.text ;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                  }

                  if( cubit.loginPasswordController.text.isNotEmpty && cubit.uniEmailController.text.isNotEmpty )

                  {
                    await cubit.login(
                      uniEmail: cubit.uniEmailController.text,
                      password: cubit.loginPasswordController.text);
                      if(cubit.loginMassage == "Logged in successfully")
                     {
                       ScaffoldMessenger.of(context).removeCurrentSnackBar();
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           duration: const Duration(
                             seconds: 1
                           ),
                           content: Center(
                               child: Text( cubit.loginMassage! )),
                         ));
                     cubit.navToHomeScreen(context);
                     }
                      else
                 {
                   ScaffoldMessenger.of(context).removeCurrentSnackBar();
                   ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                 content: Center(
                 child: Text( cubit.loginMassage! )),
                 ));
                 }

                  }

                  else

                  {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Center(
                              child: Text('Please Enter your University Email and Password first')),
                        ));
                  }

                },
                color: primeColor,
                elevation: 8,
                minWidth:300.w,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                height: MediaQuery.of(context).size.height*0.06,
                child:  Text('Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp),),
              ),
            ],
          ),
        ),
      );
    }, );
  }
}

//testing Old Code


// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//   bool passCheck = true ;
//   final uniEmailController = TextEditingController();
//   final passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//   return   BlocConsumer(builder: (context ,state){
//     return Scaffold(
//       body: SafeArea(child:
//       SingleChildScrollView(
//         child: Column(
//           //  crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children:<Widget> [
//             Container(
//               padding: const EdgeInsets.all(35),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children:<Widget> [
//                     Image.asset('assets/Group 538.png',
//                       fit: BoxFit.fill,),
//                     const SizedBox(height: 15,),
//                     Image.asset('assets/Login.png',fit: BoxFit.fill,),
//                   ],
//                 ),
//               ),
//             ),
//
//
//
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//
//                   // Email
//
//                   const Text('University Email',
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: primeColor
//                     ),),
//                   const   SizedBox(height: 5,),
//                   TextFormField(
//                     controller: uniEmailController,
//                     decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             width: 2,
//                             color: primeColor,
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//
//                             borderSide: const BorderSide(
//                                 width: 2,
//                                 color: primeColor
//                             )
//                         )
//                     ),
//                   ),
//                   const SizedBox(height: 10,),
//
//
//                   // Password
//
//                   const Text('Password',
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: primeColor
//                     ),),
//                   const SizedBox(height: 5,),
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: passCheck,
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           onPressed: (){
//                             setState(() {
//                               passCheck = !passCheck ;
//                             });},
//                           icon:  Icon(passCheck ? Icons.remove_red_eye : Icons.password,color: primeColor,),),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             width: 2,
//                             color: primeColor,
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//
//                             borderSide: const BorderSide(
//                                 width: 2,
//                                 color: primeColor
//                             )
//                         )
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10,),
//             MaterialButton(
//               //   onPressed: () async {
//               //   provider.oldPassword = passwordController.text ;
//               //   if( passwordController.text.isNotEmpty && uniEmailController.text.isNotEmpty )
//               // {  await provider.login(uniEmail: uniEmailController.text,
//               //     password: passwordController.text) ?
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => ScannerPage()))
//               //
//               //     :
//               // {
//               //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //     content: Center(child:  Text("Something is wrong .. check if your data isn't correct ")),
//               //   ))
//               // };
//               //
//               // }
//               //   else{
//               //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               //       content: Center(child:
//               //       Text('Please Enter your University Email and Password first')),
//               //     ));
//               //   }
//               //
//               //   },
//               onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Test() ));
//               },
//               color: primeColor,
//               elevation: 8,
//               minWidth:300,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               height: MediaQuery.of(context).size.height*0.06,
//               child: const Text('Login',
//                 style: TextStyle(color: Colors.white,
//                     fontSize: 25),),
//             ),
//
//
//             // const SizedBox(height: 40,),
//             //  Padding(
//             //    padding: const EdgeInsets.all(20.0),
//             //    child: Column(
//             //
//             //      mainAxisAlignment: MainAxisAlignment.start,
//             //      children:<Widget> [
//             //        MaterialButton(
//             //          onPressed: () {
//             //          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpPage()));
//             //
//             //        },
//             //          color: myPrimeColor,
//             //          elevation: 8,
//             //          minWidth:300,
//             //          shape: RoundedRectangleBorder(
//             //              borderRadius: BorderRadius.circular(12)),
//             //          height: MediaQuery.of(context).size.height*0.06,
//             //          child: const Text('Reset Password',
//             //            style: TextStyle(color: Colors.white,
//             //                fontSize: 25),),
//             //        ),
//             //
//             //      ],
//             //    ),
//             //  )
//
//
//           ],
//         ),
//       )),
//     );
//   }, listener: (context , state){});
//   }
// }
