import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
// Not Used yet
class CacheNetwork{
  static late SharedPreferences sharedPref;
  static Future cacheInitialization() async{
    sharedPref  = await SharedPreferences.getInstance();
  }

//set , get , delete , clear ( key , value )
  static Future<bool > insertToValueID ({required String key,
    required int value , }) async {
    return await sharedPref.setInt(key , value );
  }
  static Future<bool > insertToValueName ({required String key,
    required String value , }) async {
    return await sharedPref.setString(key , value );
  }

  static Future<bool > insertToValueLange ({required String key,
    required String value , }) async {
    return await sharedPref.setString(key, value );
  }
  static String getCacheData ({required String key}){
    return sharedPref.getString(key) ?? "";
  }


  //
  // static Future<bool> deleteCacheItem ({required String key}) async {
  //   return await sharedPref.remove(key);
  // }


}