import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import 'package:uni_attendance/login_page/login_page.dart';

import '../constance.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit , LayoutStates>(
       listener: (context , state ){},
     builder: (context , state ){
         final cubit = BlocProvider.of<LayoutCubit>(context);
         return Scaffold(
           body: SingleChildScrollView(
             child: Column(
               //  crossAxisAlignment: CrossAxisAlignment.stretch,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children:<Widget> [
                 Container(
                   padding: EdgeInsets.only(
                     top: 95.h,
                     bottom: 20.h,
                     right: 35.w,
                     left: 35.w
                   ),
                   child: Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children:<Widget> [
                         Image.asset('assets/images/Group 538.png',
                           fit: BoxFit.fill,),
                         Text('Reset Password ',
                           style: TextStyle(
                             color: primeColor,
                             fontSize: 40.sp,
                             fontWeight: FontWeight.bold
                         ),),
                       ],
                     ),
                   ),
                 ),

                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15.0.w,vertical: 5.0.h),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [

                       // Email

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('Old Password',
                           style: TextStyle(
                               fontSize: 20.sp,
                               color: primeColor
                           ),),
                       ),

                       TextFormField(
                         controller: cubit.oldPassController,
                         obscureText: cubit.oldPassCheck,
                         decoration: InputDecoration(
                             label: const Text('Enter Old Password'),
                             suffixIcon: IconButton(
                               onPressed: () {
                                 cubit.changePassVisibility(cubit.oldPassCheck);
                               },

                               icon:  Icon(
                                 cubit.oldPassCheck ?
                                 Icons.remove_red_eye :
                                 Icons.password,
                                 color: primeColor,),),
                             focusedBorder: OutlineInputBorder(
                               borderSide:  BorderSide(
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



                       // Password

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child:  Text('New Password',
                           style: TextStyle(
                               fontSize: 20.sp,
                               color: primeColor
                           ),),
                       ),

                       TextFormField(
                         controller: cubit.newPassController,
                         obscureText: cubit.newPassCheck,
                         decoration: InputDecoration(
                             label: const Text('Enter New Password'),
                             suffixIcon: IconButton(
                               onPressed: (){
                               cubit.changePassVisibility(cubit.newPassCheck);
                                 },

                               icon:  Icon(
                                 cubit.newPassCheck?
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

                                 borderSide: BorderSide(
                                     width: 2.w,
                                     color: primeColor
                                 )
                             )
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('Confirm New Password',
                           style: TextStyle(
                               fontSize: 20.sp,
                               color: primeColor
                           ),),
                       ),

                       TextFormField(
                         controller: cubit.newPassConController,
                         obscureText: cubit.conPassCheck,
                         decoration: InputDecoration(
                             label: const Text('Enter New Password'),
                             suffixIcon: IconButton(
                               onPressed: (){
                                 cubit.changePassVisibility(cubit.conPassCheck);
                                 },
                               icon:
                               Icon(
                                 cubit.conPassCheck ?
                                 Icons.remove_red_eye :
                                 Icons.password,
                                 color: primeColor,),),
                             focusedBorder: OutlineInputBorder(
                               borderSide:  BorderSide(
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
                     ],
                   ),
                 ),

                 Padding(
                   padding: const EdgeInsets.all(25.0),
                   child: MaterialButton(
                     onPressed: (){},
                   //   onPressed: () async {
                   //   if(cubit.newPassController.text != cubit.newPassConController.text ){
                   //
                   //     ScaffoldMessenger.of(context).showSnackBar(
                   //         const SnackBar(
                   //       content: Center(
                   //           child: Text("You New Password doesn't match" )),
                   //     ));
                   //
                   //   }
                   //   if(cubit.oldPassController.text != cubit.oldPassCheck){
                   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                   //       content: Center(child:
                   //       Text("Old password is Wrong" )),
                   //     ));
                   //
                   //   }
                   //   else
                   //
                   //   if(newPassController.text == newPassConController.text && oldPassController.text == provider.oldPassword ){
                   //     await provider.resetPassword( old_password: oldPassController.text, new_password: newPassController.text);
                   //
                   //     if(provider.passMassage == "password has been changed")
                   //       Alert(
                   //         context: context,
                   //         type: AlertType.success,
                   //         title: "DONE",
                   //         desc: "Your Password Was Changed Successfully",
                   //         buttons: [
                   //           DialogButton(
                   //             color: myPrimeColor,
                   //             onPressed: () => Navigator.pop(context),
                   //             width: 125,
                   //             child: const Text(
                   //               "OK",
                   //               style: TextStyle(color: Colors.white, fontSize: 25),
                   //             ),
                   //           )
                   //         ],
                   //       ).show();
                   //     else{ Alert(
                   //       context: context,
                   //       type: AlertType.warning,
                   //       title: "OPS",
                   //       desc: provider.passMassage,
                   //       buttons: [
                   //         DialogButton(
                   //           color: myPrimeColor,
                   //           onPressed: () => Navigator.pop(context),
                   //           width: 125,
                   //           child: const Text(
                   //             "OK",
                   //             style: TextStyle(color: Colors.white, fontSize: 25),
                   //           ),
                   //         )
                   //       ],
                   //     ).show();}
                   //
                   //   }
                   // },
                     color: primeColor,
                     elevation: 15,
                     minWidth:300.w,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12)),
                     height: MediaQuery.of(context).size.height*0.06,
                     child: Text('Change Password',
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 25.sp),),
                   ),
                 ),

                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children:<Widget> [

                     MaterialButton(  onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));

                     },
                       color: primeColor,
                       elevation: 8,
                       minWidth:300,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12.w)),
                       height: MediaQuery.of(context).size.height*0.06,
                       child: Text('Go To Log In',
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 25.sp),),
                     ),

                   ],
                 )


               ],
             ),
           ),
         );
     }, );
  }
}
