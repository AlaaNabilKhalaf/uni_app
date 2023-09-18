import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import '../constance.dart';

class LoginPage extends StatelessWidget {
const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit , LayoutStates>(
     listener: (context , state) {},
        builder: (context , state){
       final cubit = BlocProvider.of<LayoutCubit>(context);
       return  Scaffold(
         body: SingleChildScrollView(
         child: Column(
         //  crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisAlignment: MainAxisAlignment.start,
         children:<Widget> [
           Container(
             padding: const EdgeInsets.all(35),
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
             padding: const EdgeInsets.all(15.0),
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
                   controller: cubit.uniEmailController,
                   decoration: InputDecoration(
                     hintText: 'Email',
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           width: 2.w,
                           color: primeColor,
                         ),
                         borderRadius: BorderRadius.circular(25),
                       ),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25),

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
                   controller: cubit.passwordController,
                   obscureText: cubit.loginPassCheck,
                   decoration: InputDecoration(
                     hintText: 'Password',
                       suffixIcon: IconButton(
                         onPressed: cubit.changePassVisibility(cubit.loginPassCheck),
                         icon:  Icon(
                           cubit.loginPassCheck ?
                         Icons.remove_red_eye :
                         Icons.password,
                           color: primeColor,),),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           width: 2.w,
                           color: primeColor,
                         ),
                         borderRadius: BorderRadius.circular(25),
                       ),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25),
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
             onPressed: cubit.navToHomeScreen(context),
             color: primeColor,
             elevation: 8,
             minWidth:300.w,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12)),
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
        }
       );
  }
}
