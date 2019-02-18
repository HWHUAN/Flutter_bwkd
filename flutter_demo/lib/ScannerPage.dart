import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'dart:async';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:pointycastle/pointycastle.dart';

class ScannerPage extends StatefulWidget {

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  ScannerPageState createState() => new ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> {
  Future<String> _barcodeString;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('QRCode Reader Example'),
      ),
      body: new Center(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data != null ? snapshot.data : '');
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
//          getHuText();
          setState(() {
            _barcodeString = new QRCodeReader()
                .setAutoFocusIntervalInMs(200)
                .setForceAutoFocus(true)
                .setTorchEnabled(true)
                .setHandlePermissions(true)
                .setExecuteAfterPermissionGranted(true)
                .scan();
          });
        },
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }


  getHuText(){
    var text = "3112003057";
    String key="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1nMYS0QLT6yAgHM1d+pqYhRRhTABXp/kq0W7nIUT3etjSWi8JfoqvkfShINF4CovBSTJ7sNko7j3yKEFn5HzaF1INKWTVfZprpEyFBnAa+ydBiVHKQ85vRyyoX67lMSKOrnq7B37h5bdnE7faoajsaOCnx5wtlya7AGVB4fxfOQIDAQAB";
    BigInt modulus =  BigInt.parse(key,radix: 16);
    BigInt exponent = BigInt.from(65537);
    var pubKey = RSAPublicKey(modulus, exponent);
    AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(pubKey));
    Uint8List output = cipher.process(utf8.encode(text));
    var base64EncodedText = base64Encode(output);
    print("base64EncodedText="+base64EncodedText);
  }
}
