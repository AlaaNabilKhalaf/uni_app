import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_attendance/login_page/login_page.dart';
import '../../local_network/local_network.dart';
import 'layout_states.dart';
import 'dart:io';
import 'package:http/http.dart%20';
import 'package:http/http.dart ' as http ;

class LayoutCubit extends Cubit <LayoutStates>{
  LayoutCubit() : super (InitialState());

  bool oldPassCheck = true ;
  bool newPassCheck = true ;
  bool conPassCheck = true ;

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newPassConController = TextEditingController();

  bool loginPassCheck = true ;
  final uniEmailController = TextEditingController();
  final passwordController = TextEditingController();

  changePassVisibility(passCheck){
   passCheck = !passCheck;
    emit(PassVisibilityChanged());
  }

  navToHomeScreen(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> const LoginPage() ));
    emit(NavToHomeScreenState());
  }

  File? image ;
  String? theKey ;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImagePickedState());
    if (image == null) return ;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    emit(ImageReturnedState());
    return image;
  }

  allApiFun(){

  String? userName ;
  String? passMassage ;
  int? userId ;
  String? loginMassage ;
  int secondIndex = 0 ;
  String? oldPassword ;



  Future<bool> login({required String uniEmail, required String password,}) async {
    try{ Response response = await http.post(
        Uri.parse('http://66.29.130.92:5000/api/mobile_api/student_login'),
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
    if(response.statusCode == 200){
      Map<String , dynamic> data = jsonDecode(response.body);
      print("enter status 200");
      if (data["message"] == "Logged in successfully")
      {
        loginMassage = data["message"] ;
        userId = data["student_id"];
        CacheNetwork.insertToValueID(
          key: 'student_id',  value: data['student_id'] ,
        );
        CacheNetwork.insertToValueName(key: "student_name", value: data["student_name"]);
        debugPrint(data['message']);
        theKey = 'student_id' ;


        return true;
      }
      else{


        loginMassage = data["message"] ;
        return false;
      }
    }
    }catch(e){

      loginMassage = 'Make Sure your Email and Password are Right ';
      return false;
    }
    return false;
  }


  Future<bool> resetPassword({required String old_password, required String new_password}) async {
    try{ Response response = await http.post(
        Uri.parse('http://66.29.130.92:5000/api/mobile_api/change_password?student_id=$userId'),
        body: {
          'old_password' : old_password,
          'new_password' : new_password,
        },
        headers: {
          'accept': 'application/json',
          'User':'admin' ,
          'apikey': 'apikey' ,
          'Content-Type': 'application/x-www-form-urlencoded'
        }
    );
    print(response.statusCode);
    print(userId);
    if(response.statusCode == 200){
      Map<String , dynamic> data = jsonDecode(response.body);
      print("enter status 200");
      if (data["message"] == "password has been changed")
      {     passMassage = data["message"];
      return true ;}
      else{

        passMassage = data["message"];;
        return false;
      }
    }
    }catch(e){

      passMassage = 'Something went wrong .. try again';
      return false;
    }
    return true;
  }


  Future<bool> qrGenerator() async {
    try{ Response response = await http.post(
        Uri.parse('http://66.29.130.92:5000/api/mobile_api/add_attendance?student_id=$userId,lecture_id= '),

        headers: {
          'accept': 'application/json' ,
          'User':'admin' ,
          'apikey': 'apikey' ,
          'Content-Type': 'application/x-www-form-urlencoded'
        }
    );
    print(response.statusCode);
    print(userId);
    if(response.statusCode == 200){
      Map<String , dynamic> data = jsonDecode(response.body);
      debugPrint("enter status 200");
      if (data["message"] == "password has been changed")
      {     passMassage = data["message"];
      return true ;}
      else{

        passMassage = data["message"];;
        return false;
      }
    }
    }catch(e){

      passMassage = 'Something went wrong .. try again';
      return false;
    }
    return true;
  }

}
}