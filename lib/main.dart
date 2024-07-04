// import 'dart:io';
import 'package:flutter/material.dart';
// webview
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// Permissions
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

// Flutter App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoseTracker',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF000000),
        secondaryHeaderColor: const Color(0xFF000000),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PoseTrackerPage(title: 'PoseTracker'),
    );
  }
}

class PoseTrackerPage extends StatefulWidget {
  const PoseTrackerPage({super.key, required this.title});
  final String title;
  final textMsgStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13,
  );

  @override
  State<PoseTrackerPage> createState() => _PoseTrackerPageState();
}

class _PoseTrackerPageState extends State<PoseTrackerPage> {
  // Constants
  // API request your token provided on our dashboard on posetracker.com (It's free <3)
  final String API_KEY = "ade62024-02b7-4669-9bca-66116748ea80";
  // Below is the main url to reach our API
  final String POSETRACKER_API_URL =
      "https://posetracker.com/pose_tracker/tracking";
  // Our API request the exercise you want to track and count
  final String exercise = "squat";
  // Our API request the difficulty of the exercise (by default it's set to normal)
  final String difficulty = "easy";
  // You can request API to display user skeleton or not (by default it's set to true)
  final bool skeleton = true;
  // retrieve webview dimensions
  final int width = 350;
  // webView.resources.displayMetrics.
  final int height = 350;

  // states
  String _displayText = "";
  String _api_url = "";

  // instances in use to configure js bridge and permissions
  late PlatformWebViewControllerCreationParams params;
  late WebViewController _webviewController;

  @override
  void initState() {
    super.initState();

    // init url and text
    _api_url =
        "$POSETRACKER_API_URL?token=$API_KEY&exercise=$exercise&difficulty=$difficulty&skeleton=$skeleton&width=$width&height=$height";
    _displayText = "Waiting for API Data...";

    // configure JS in webview depending on platform
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      // ios
      // configure specific params here
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      // android
      params = const PlatformWebViewControllerCreationParams();
    }

    // init common webcontroller
    _webviewController = WebViewController.fromPlatformCreationParams(params);

    // configure specific params for android here
    if (_webviewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      AndroidWebViewController ctrler =
          (_webviewController.platform as AndroidWebViewController);
      ctrler.setMediaPlaybackRequiresUserGesture(false);
      ctrler.setJavaScriptMode(JavaScriptMode.unrestricted);
      ctrler.setOnPlatformPermissionRequest((request) {
        request.grant();
      });
    }

    // add JsBridge
    _webviewController.addJavaScriptChannel("flutterJsMessageBridge",
        onMessageReceived: (JavaScriptMessage javaScriptMessage) {
      setState(() {
        _displayText = javaScriptMessage.message;
      });
    });
    _webviewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        setState(() {
          _displayText = "Waiting for API data...";
        });
      },
      onPageFinished: (String url) {
        setState(() {
          _webviewController.runJavaScript("""
              javascript:(function() {
                window.webViewCallback = function(info) {
                  flutterJsMessageBridge.postMessage(JSON.stringify(info ? info : 'No data'));
                }
              })();
            """);
        });
      },
    ));

    // request camera permision then start url
    Permission.camera.request().whenComplete(
        () => _webviewController.loadRequest(Uri.parse(_api_url)));
  }

  @override
  Widget build(BuildContext context) {
    print('DATA: $_displayText');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            // ===== Webview =====
            Expanded(
              flex: 3,
              child: WebViewWidget(controller: _webviewController),
            ),
            // ===== Text Status =====
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Wrap(
                  children: [
                    Text("Data: ", style: widget.textMsgStyle),
                    Text(
                      _displayText,
                      style: widget.textMsgStyle,
                    ),
                  ],
                ),
              ),
            ),

            // ===== Button area =====
            Expanded(
              flex: 0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: widget.textMsgStyle),
                onPressed: () {
                  // reload page on press
                  setState(() {
                    _displayText = "Reloading ! ";
                  });
                  _webviewController.loadRequest(
                    Uri.parse(_api_url),
                  );
                },
                child: const Text(
                  "Refresh",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
