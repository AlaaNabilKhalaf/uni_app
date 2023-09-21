import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../home_page/home_page.dart';
import '../../local_network/local_network.dart';
import 'layout_states.dart';
import 'dart:io';
import 'package:http/http.dart%20';
import 'package:http/http.dart ' as http ;

 // This cubit provides Screens UI, ABI Methods and returned date

class LayoutCubit extends Cubit <LayoutStates>{
  LayoutCubit() : super (LayoutInitialState());

  //Change Password Screen UI Items
  bool oldPassCheck = true ;
  bool newPassCheck = true ;
  bool conPassCheck = true ;

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newPassConController = TextEditingController();

  changeOldPassCheckVisibility(){
    oldPassCheck = !oldPassCheck;
    emit(OldPasswordVisibilityChanged());

  }
  changeNewPassCheckVisibility(){
    newPassCheck = !newPassCheck ;
    emit(NewPasswordVisibilityChanged());

  }
  changeConPassCheckVisibility(){
    conPassCheck = !conPassCheck;
    emit(NewPasswordConVisibilityChanged());
  }



  //Login Screen UI Items
  bool loginPassCheck = true ;
  final uniEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  changeLoginPassVisibility(){
    loginPassCheck = !loginPassCheck;
    emit(LoginPasswordVisibilityChanged());
  }

  navToHomeScreen(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> const HomePage()));
    emit(NavToHomeScreenState());
  }



  //Home Screen UI Items
  File? image ;

  Future pickImage() async {
    emit(ImagePickerLoadingState());
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImagePickedState());
    if (image == null) return ;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    emit(ImageReturnedState());
    return image;
  }


 //ApI Methods


// Login Method Items
  int? userId ;
  String? loginMassage ;
  String? theKey ;
  String? oldPassword  ;

  Future<void> login(
       { required String uniEmail, required String password, } ) async {
    emit(LoginLoadingState());
    try{ Response response = await http.post(
        Uri.parse('https://attendance.ebdaa-business.com/api/mobile_api/student_login'),
        body: {
          'university_email' : uniEmail,
          'password' : password
        },
        headers: {
          'accept': 'application/json' ,
          'User': 'admin' ,
          'apikey': 'apikey' ,
          'Content-Type': 'application/x-www-form-urlencoded'
        }
    );
    Map<String , dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200)
      {
        loginMassage = data["message"] ;
        userId = data["student_id"];

        CacheNetwork.insertToValueID(
          key: 'student_id',  value: data['student_id'] ,
        );
        CacheNetwork.insertToValueName(key: "student_name", value: data["student_name"]);
        debugPrint(data['message']);
        theKey = 'student_id' ;

        emit(LoginSuccessState());

      }

    else{
      loginMassage = "${data["message"]}";
      print("8888888888888888888888888888888888888888888${response.statusCode}");
      emit(LoginFailureState());
    }
    }
    catch (e) {
      loginMassage = 'Something went wrong, please check your Email and Password and try again';
      emit(LoginFailureState());

    }

  }


// Reset Password Method Items
  String? passMassage ;

  Future<void> resetPassword(
       {required String oldPassword, required String newPassword}) async {
    emit(ResetPasswordLoadingState());
    try{ Response response = await http.post(
        Uri.parse('https://attendance.ebdaa-business.com/api/mobile_api/change_password?student_id=$userId'),
        body: {
          'old_password' : oldPassword,
          'new_password' : newPassword,
        },
        headers: {
          'accept': 'application/json',
          'User':'admin' ,
          'apikey': 'apikey' ,
          'Content-Type': 'application/x-www-form-urlencoded'
        }
    );
    print("8888888888888888888888888888888888888888888${response.statusCode}");
    print(userId);

    Map<String , dynamic> data = jsonDecode(response.body);
    if( response.statusCode == 200 )
    {
      passMassage = data["message"] ;
      emit(ResetPasswordSuccessState());

    }
    else
    {
      passMassage = data["message"] ;
      emit(ResetPasswordFailureState());
    }
    } catch (e) {
      passMassage = 'Something went wrong .. please try again';
      emit(ResetPasswordFailureState());

    }
  }

//
// String? userName ;
// int secondIndex = 0 ;

//QR Method
//   Future<void> qrGenerator() async {
//     try{ Response response = await http.post(
//         Uri.parse('http://66.29.130.92:5000/api/mobile_api/add_attendance?lecture_id=${lecId(barcode!.code.toString())}&student_id=${widget.userId}'),
//         headers: {
//           'accept': 'application/json' ,
//           'User': 'admin' ,
//           'apikey': 'apikey',
//           // 'apikey': 'apikey',
//         }
//     );
//     // debugPrint(response.statusCode);
//     debugPrint('""""""""""""""""""""""""""""""""""""""""http://66.29.130.92:5000/api/mobile_api/add_attendance?lecture_id= ${widget.userId}&student_id=0');
//     if(response.statusCode == 200){
//       var lectureId = lecId(barcode!.code.toString());
//       debugPrint('lecture id is $lectureId');
//       Map<String , dynamic> data = jsonDecode(response.body);
//       ScaffoldMessenger.of(context).removeCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Center(child:  Text('${data["message"]}')),
//       ));
//
//     }
//     }catch(e){
//       ScaffoldMessenger.of(context).removeCurrentSnackBar();
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Center(child:  Text('something went wrong try again')),
//       ));
//
//     }
//
//   }





}