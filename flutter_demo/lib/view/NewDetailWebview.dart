import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/bean/NewsResData.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewDetailWebview extends StatelessWidget{
  final News mNews;
  NewDetailWebview({this.mNews});

  @override
  Widget build(BuildContext context) {
    assert(mNews!=null);
    return WebviewScaffold(
      url: mNews.src,
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }

}