import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart ' as http ;
import 'package:http/http.dart%20';
import '../constance.dart';

class QrScanner extends StatefulWidget {
 const QrScanner({
    super.key ,
  required this.userId });
  final int userId ;

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
        Uri.parse('http://66.29.130.92:5000/api/mobile_api/add_attendance?lecture_id=${lecId(barcode!.code.toString())}&student_id=${widget.userId}'),
        headers: {
          'accept': 'application/json' ,
          'User': 'admin' ,
          'apikey': 'apikey',
          // 'apikey': 'apikey',
        }
    );
    // debugPrint(response.statusCode);
    debugPrint('""""""""""""""""""""""""""""""""""""""""http://66.29.130.92:5000/api/mobile_api/add_attendance?lecture_id= ${widget.userId}&student_id=0');
    if(response.statusCode == 200){
      var lectureId = lecId(barcode!.code.toString());
      debugPrint('lecture id is $lectureId');
      Map<String , dynamic> data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(child:  Text('${data["message"]}')),
      ));

    }
    }catch(e){
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

    debugPrint( '""""""""""""""""""""""""""""""""DONEEEEEEEEEEEE');


  }

  Widget buildResult
      ()=> Container(
    padding: const EdgeInsets.all(10).w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      color: Colors.grey.shade100,
    ),
    child: Text(
      barcode != null ? 'Link is : ${barcode!.code}' :
      'Scan a Code!',
      maxLines: 4,


    ),
  );

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



        IconButton(onPressed: ()async{
          await controller?.flipCamera();
          setState(() {
          });
        }, icon: FutureBuilder(
          future: controller?.getCameraInfo(),
          builder: (context , snapshot){
            if(snapshot.data !=null ){
              return const Icon( Icons.switch_camera);
            }else{
              return Container();
            }
          },
        )),
      ],
    ),
  );

}








