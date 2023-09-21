// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:uni_attendance/change_password_page/change_password_page.dart';
// import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
// import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
// import '../constance.dart';
// import '../scanner_page/scanner_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LayoutCubit , LayoutStates>(
//         listener: (context , state ){},
//       builder: (context , state ){
//           final cubit = BlocProvider.of<LayoutCubit>(context);
//       return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
//                       color: primeColor,
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/jrgknf.png'),fit: BoxFit.fill)
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         top: 70.h, left: 35.w,
//                         child: Text('Welcome',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30.sp
//                           ),),),

//                       Positioned(left: 225.w,top: 35.h,child: DropdownButton<String>(
//                         icon: const Icon(
//                           Icons.more_vert_outlined,
//                           color: Colors.white,),
//                         iconSize: 30,
//                         underline: const SizedBox(height: 0,),
//                         onChanged: (String? value) {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context)=> const ChangePasswordPage()));

//                         },
//                         items: [
//                           DropdownMenuItem(value: '0',child:  Text('Change Password',style: TextStyle(
//                               fontSize: 15.sp,color: primeColor ),),)
//                         ],), ),

//                       Positioned(
//                         top: 100.h,right: 50.w,
//                         child: GestureDetector(
//                           onTap: () {
//                             cubit.pickImage();
//                           },
//                           child:cubit.image == null ? Container(
//                               padding: const EdgeInsets.all(22).w,
//                               decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white
//                               ),
//                               child:const Icon(
//                                 Icons.add_a_photo_outlined,
//                                 color: primeColor,
//                                 size: 40,
//                               )
//                           ) : Container(
//                               clipBehavior: Clip.antiAlias,
//                               decoration: const  BoxDecoration(
//                                 // borderRadius: BorderRadius.circular(10.w),
//                                 shape: BoxShape.circle
//                               ),
//                               child: Image.file(
//                                 cubit.image!,
//                                 fit: BoxFit.cover,
//                                 height: 100.h,
//                                 width: 100.w,
//                               )),
//                         ),)
//                     ],
//                   ),

//                 )),
//             Expanded(
//                 flex: 3,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     MaterialButton(onPressed: (){

//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context )=> QrScanner(
//                              userId:  cubit.userId!
//                         // userId: 0,
//                           )));
//                     },
//                       elevation: 50,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.grey.shade200,
//                         maxRadius: 80.r,
//                         child: Image.asset('assets/images/qr-code.png',),
//                       ),),

//                     Text('Scan QR Code',
//                       style: TextStyle(
//                           fontSize: 30.sp,
//                           fontWeight: FontWeight.w300,
//                           color: primeColor),)
//                   ],
//                 ))
//           ],
//         ),

//       );
//     }, );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uni_attendance/change_password_page/change_password_page.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_cubit.dart';
import 'package:uni_attendance/cubit/layout_cubit/layout_states.dart';
import '../constance.dart';
import '../generated/l10n.dart';
import '../scanner_page/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        final lang = S.of(context);

        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(25)),
                        color: primeColor,
                        image: DecorationImage(
                            image: AssetImage('assets/images/jrgknf.png'),
                            fit: BoxFit.fill)),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 70.h,
                          left: cubit.isEnglish() ? 35.w : 0,
                          right: cubit.isEnglish() ? 0 : 35.w,
                          child: Text(
                            lang.Welcome,
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.sp),
                          ),
                        ),
                        Positioned(
                          left: cubit.isEnglish() ? 225.w : 0,
                          right: cubit.isEnglish() ? 0 : 225.w,
                          top: 40.h,
                          child: DropdownButton<String>(
                            icon: const Icon(
                              Icons.more_vert_outlined,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            underline: const SizedBox(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePasswordPage()));
                            },
                            items: [
                              DropdownMenuItem(
                                value: '0',
                                child: Text(
                                  lang.ResetPassword,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: primeColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 100.h,
                          //  left: cubit.isEnglish()?
                          // 0 : 50.w,
                          right: cubit.isEnglish() ? 50.w : 240.w,
                          child: GestureDetector(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: cubit.image == null
                                ? Container(
                                    padding: const EdgeInsets.all(22).w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: primeColor,
                                      size: 40,
                                    ))
                                : Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10.w),
                                        shape: BoxShape.circle),
                                    child: Image.file(
                                      cubit.image!,
                                      fit: BoxFit.cover,
                                      height: 100.h,
                                      width: 100.w,
                                    )),
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QrScanner(userId: cubit.userId!
                                          // userId: 0,
                                          )));
                        },
                        elevation: 50,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          maxRadius: 80.r,
                          child: Image.asset(
                            'assets/images/qr-code.png',
                          ),
                        ),
                      ),
                      Text(
                        lang.QrScanner,
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w300,
                            color: primeColor),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
