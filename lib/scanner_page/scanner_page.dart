import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart ' as http ;
import 'package:http/http.dart%20';
import '../constance.dart';

class QrScanner extends StatefulWidget {
  QrScanner({
    super.key ,
  required this.userId });
  final int userId ;
String? mass ;
  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller ;
  Barcode? barcode ;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context)
  {

    return SafeArea(
      child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children:<Widget> [
              buildQrViewer(context),
              Positioned(bottom: 10.h,child: buildResult(),),
              Positioned(top: 10.h,child: buildControlButtons(),),

            ],
          )),
    );

  }
  Widget buildQrViewer (BuildContext context )=> QRView(
        key: qrKey,
    onQRViewCreated: onQRViewCreated ,
    overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width*0.8,
        borderRadius: 10,
        borderColor: primeColor,
        borderLength: 10,
        borderWidth: 20
    ),);


  Future<void> qrGenerator() async {
    try{ Response response = await http.post(
        Uri.parse('https://attendance.ebdaa-business.com/api/mobile_api/add_attendance?lecture_id=${lecId(barcode!.code.toString())}&student_id=${widget.userId}'),
        headers: {
          'accept': 'application/json' ,
          'User': 'admin' ,
          'apikey': 'apikey',
        }
    );
    debugPrint('""""""""""""""""""""""""""""""""""""""""http://66.29.130.92:5000/api/mobile_api/add_attendance?lecture_id= ${widget.userId}&student_id=0');
    Map<String , dynamic> data = jsonDecode(response.body);
    if(response.statusCode == 200)
    {
      var lectureId = lecId(barcode!.code.toString());
      debugPrint('lecture id isssssssssssssssssssssssssssssssssssssssss $lectureId');
      print(data["message"]);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(
            seconds: 2
        ),
        content: Center(child: Text('${data["message"]}')),
      ));
    }
    else
    {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(
            seconds: 2
        ),
        content: Center(child: Text('${data["message"]}')),
      ));
    }
    } catch(e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(
          seconds: 3
        ),
        content: Center(child:  Text('something went wrong try again')),
      ));
    }

  }

  String lecId(String s){
    String s = barcode!.code.toString();
    String id = s.replaceAll(RegExp('[^0-9]'), '');
    debugPrint('lecture id issssssssssss$id');
    return id;
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() =>this.controller = controller,
    );
    controller.scannedDataStream.listen((barcod){

      setState(() {
        barcode = barcod ;
        qrGenerator() ;
      });
    } );

  }

  Widget buildResult
      ()=> barcode == null ? Container(
    padding: const EdgeInsets.all(10).w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      color: Colors.grey.shade100,
    ),
    child: const Text(
      'Scan a Code!',
      maxLines: 4,


    ),
  ) : const SizedBox() ;

  Widget buildControlButtons()=> Container(
    padding: const EdgeInsets.all(10).w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      color: Colors.grey.shade100,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            onPressed: () async {
          await controller?.toggleFlash();
          setState(() {

          });
        }, icon: FutureBuilder<bool?>(
          future: controller?.getFlashStatus(),
          builder: (context , snapshot){
            if(snapshot.data !=null ){
              return Icon( snapshot.data! ? Icons.flash_on: Icons.flash_off);
            }else{
              return Container();
            }
          },
        )
        ),
        IconButton(onPressed: () async
        {
          await controller?.flipCamera();
          setState(() {
          });
        },
            icon: FutureBuilder(
          future: controller?.getCameraInfo(),
          builder: (context , snapshot){
            if(snapshot.data !=null ){
              return const Icon( Icons.switch_camera);
            }
            else
            {
              return Container();
            }
          },
        )),
      ],
    ),
  );

}








