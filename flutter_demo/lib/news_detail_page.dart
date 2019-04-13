import 'dart:async';

import 'package:flutter/material.dart';
import 'bean/NewsResData.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatelessWidget{

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  NewsDetailPage({this.mNews});
  final News mNews;

  @override
  Widget build(BuildContext context) {
    assert(mNews!=null);
    return WebviewScaffold(
      url: mNews.src,
      appBar: new AppBar(
        title: Text('${mNews.title}'),
      ),
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
    // TODO: implement build
    /*return Scaffold(
      appBar: AppBar(
        title: Text('${mNews.title}'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(_controller.future),
          const SampleMenu(),
        ],
      ),
      body: WebView(
        initialUrl: mNews.src,
        javaScriptMode: JavaScriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: favoriteButton(),
    );*/
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Favorited $url")),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}

class SampleMenu extends StatelessWidget {
  const SampleMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('You selected: $value')));
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        const PopupMenuItem<String>(
          value: 'Item 1',
          child: Text('Item 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Item 2',
          child: Text('Item 2'),
        ),
      ],
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text("No back history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  controller.goForward();
                } else {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("No forward history item")),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}