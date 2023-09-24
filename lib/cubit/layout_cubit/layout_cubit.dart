import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../constance.dart';
import '../../home_page/home_page.dart';
import '../../local_network/local_network.dart';
import 'layout_states.dart';
import 'dart:io';
import 'package:http/http.dart%20';
import 'package:http/http.dart ' as http;
import 'package:intl/intl.dart';

// This cubit provides Screens UI, ABI Methods and returned date

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  //Change Password Screen UI Items
  bool oldPassCheck = true;
  bool newPassCheck = true;
  bool conPassCheck = true;

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newPassConController = TextEditingController();

  changeOldPassCheckVisibility() {
    oldPassCheck = !oldPassCheck;
    emit(OldPasswordVisibilityChanged());
  }

  changeNewPassCheckVisibility() {
    newPassCheck = !newPassCheck;
    emit(NewPasswordVisibilityChanged());
  }

  changeConPassCheckVisibility() {
    conPassCheck = !conPassCheck;
    emit(NewPasswordConVisibilityChanged());
  }

  //Login Screen UI Items
  bool loginPassCheck = true;
  final uniEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  changeLoginPassVisibility() {
    loginPassCheck = !loginPassCheck;
    emit(LoginPasswordVisibilityChanged());
  }

  navToHomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
    emit(NavToHomeScreenState());
  }

  //Home Screen UI Items
  File? image;

  Future pickImage() async {
    emit(ImagePickerLoadingState());
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImagePickedState());
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    emit(ImageReturnedState());
    return image;
  }

  //ApI Methods

// Login Method Items
  int? userId;
  String? loginMassage;
  String? theKey;
  String? oldPassword;

  Future<void> login({
    required String uniEmail,
    required String password,
  }) async {
    emit(LoginLoadingState());
    Response response = await http.post(
        Uri.parse(
            'https://sigma.ebdaa-business.com/api/mobile_api/student_login'),
        body: {
          'university_email': uniEmail,
          'password': password
        },
        headers: {
          'accept': 'application/json',
          'User': 'admin',
          'apikey': 'apikey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      loginMassage = data["message"];
      userId = data["student_id"];

      CacheNetwork.insertToValueID(
        key: 'student_id',
        value: data['student_id'],
      );
      CacheNetwork.insertToValueName(
          key: "student_name", value: data["student_name"]);
      theKey = 'student_id';
      emit(LoginSuccessState());
    } else {
      loginMassage = "${data["message"]}";
      emit(LoginFailureState());
    }
  }

// Reset Password Method Items
  String? passMassage;

  Future<void> resetPassword(
      {required String oldPassword, required String newPassword}) async {
    emit(ResetPasswordLoadingState());

    Response response = await http.post(
        Uri.parse(
            'https://sigma.ebdaa-business.com/api/mobile_api/change_password?student_id=$userId'),
        body: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
        headers: {
          'accept': 'application/json',
          'User': 'admin',
          'apikey': 'apikey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      passMassage = data["message"];
      emit(ResetPasswordSuccessState());
    } else {
      passMassage = data["message"];
      emit(ResetPasswordFailureState());
    }
  }


// Localizations Items
  String? theLangKey;
  Locale myCurrentLang = const Locale('en');

  bool isEnglish() {
    // emit(LanguageIsEnglish());
    return Intl.getCurrentLocale() == 'en';
  }

  changeLocale(){
    if(myCurrentLang == const Locale('ar')){
      myCurrentLang = const Locale('en');
      CacheNetwork.insertToValueLange(
        key: 'current_lang',
        value: 'en',
      );
      emit(LanguageChangedToEnglish());
    }else{
      myCurrentLang = const Locale('ar');
      CacheNetwork.insertToValueLange(
        key: 'current_lang',
        value: 'ar',
      );
      emit(LanguageChangedToArabic());

    }

  }


  //QR Scanner Items
 // For More code Reforming


  // final qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller ;
  // Barcode? barcode ;
  // String? qrMassage ;
  //
  // Widget buildQrViewer (BuildContext context )=> QRView(
  //   key: qrKey,
  //   onQRViewCreated: onQRViewCreated ,
  //   overlay: QrScannerOverlayShape(
  //       cutOutSize: MediaQuery.of(context).size.width*0.8,
  //       borderRadius: 10,
  //       borderColor: primeColor,
  //       borderLength: 10,
  //       borderWidth: 20
  //   ),);
  //
  // Future<void> qrGenerator() async {
  //   emit(SendAttendanceLoadingState());
  //   try{ Response response = await http.post(
  //       Uri.parse('https://attendance.ebdaa-business.com/api/mobile_api/add_attendance?lecture_id=${lecId(barcode!.code.toString())}&student_id=$userId'),
  //       headers: {
  //         'accept': 'application/json' ,
  //         'User': 'admin' ,
  //         'apikey': 'apikey',
  //       }
  //   );
  //   Map<String , dynamic> data = jsonDecode(response.body);
  //   if(response.statusCode == 200)
  //   {
  //     var lectureId = lecId(barcode!.code.toString());
  //
  //     print(data["message"]);
  //     qrMassage = data["message"];
  //     emit(SendAttendanceSuccessState());
  //     // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //   duration: const Duration(
  //     //       seconds: 2
  //     //   ),
  //     //   content: Center(child: Text('${data["message"]}')),
  //     // ));
  //   }
  //   else
  //   {
  //     qrMassage = data["message"];
  //     emit(SendAttendanceFailureState());
  //     // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //   duration: const Duration(
  //     //       seconds: 2
  //     //   ),
  //     //   content: Center(child: Text('${data["message"]}')),
  //     // ));
  //   }
  //   } catch(e) {
  //     emit(SendAttendanceFailureCatchState());
  //     // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //   duration: Duration(
  //     //       seconds: 3
  //     //   ),
  //     //   content: Center(child:  Text('something went wrong try again')),
  //     // ));
  //   }
  //
  // }
  //
  // String lecId(String s){
  //   String s = barcode!.code.toString();
  //   String id = s.replaceAll(RegExp('[^0-9]'), '');
  //   return id;
  // }
  //
  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   emit(ControllerInitialed());
  //   controller.scannedDataStream.listen((barcod){
  //     barcode = barcod ;
  //     qrGenerator() ;
  //     emit(SendAttendanceLoadingState());
  //   } );
  // }
  //
  // Widget buildResult ()=> barcode == null ? Container(
  //   padding: const EdgeInsets.all(10).w,
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(10.w),
  //     color: Colors.grey.shade100,
  //   ),
  //   child: const Text(
  //     'Scan a Code!',
  //     maxLines: 4,
  //
  //
  //   ),
  // ) : const SizedBox() ;
  //
  // Widget buildControlButtons()=> Container(
  //   padding: const EdgeInsets.all(10).w,
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(10.w),
  //     color: Colors.grey.shade100,
  //   ),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       IconButton(
  //           onPressed: () async {
  //             await controller?.toggleFlash();
  //             emit(Flash());
  //           }, icon: FutureBuilder<bool?>(
  //         future: controller?.getFlashStatus(),
  //         builder: (context , snapshot){
  //           if(snapshot.data !=null ){
  //             return Icon( snapshot.data! ? Icons.flash_on: Icons.flash_off);
  //           }else{
  //             return Container();
  //           }
  //         },
  //       )
  //       ),
  //       IconButton(onPressed: () async
  //       {
  //         await controller?.flipCamera();
  //         emit(CameraFlip());
  //       },
  //           icon: FutureBuilder(
  //             future: controller?.getCameraInfo(),
  //             builder: (context , snapshot){
  //               if(snapshot.data !=null ){
  //                 return const Icon( Icons.switch_camera);
  //               }
  //               else
  //               {
  //                 return Container();
  //               }
  //             },
  //           )),
  //     ],
  //   ),
  // ) ;
}










