import 'dart:convert';
import 'package:flutter/material.dart'; // import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart'; // webview
import 'package:webview_flutter_android/webview_flutter_android.dart'; // Import for Android features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart'; // Import for iOS features.
import 'package:permission_handler/permission_handler.dart'; // Permissions

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
  final String API_KEY = "ade62024-02b7-4669-9bca-66116748ea80";
  final String POSETRACKER_API_URL =
      "https://posetracker.com/pose_tracker/tracking";
  late String exercise;
  final String difficulty = "easy";
  final bool skeleton = true;
  final int width = 450;
  final int height = 450;
  int _currentCount = 0;

  // states
  String _api_url = "";

  // instances in use to configure js bridge and permissions
  late PlatformWebViewControllerCreationParams params;
  late WebViewController _webviewController;

  @override
  void initState() {
    super.initState();

    exercise = _convertToTitle(widget.title);

    // init url and text
    _api_url =
        "$POSETRACKER_API_URL?token=$API_KEY&exercise=$exercise&difficulty=$difficulty&skeleton=$skeleton&width=$width&height=$height";

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
        if (javaScriptMessage.message.isNotEmpty) {
          var jsonData = jsonDecode(javaScriptMessage.message);
          _currentCount = jsonData['current_count'] ?? 0;
        }
      });
    });
    _webviewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        setState(() {});
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
          () => _webviewController.loadRequest(
            Uri.parse(_api_url),
          ),
        );
  }

  String _convertToTitle(String input) {
    return input.toLowerCase().replaceAll(' ', '_');
  }

  @override
  Widget build(BuildContext context) {
    print(exercise);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ===== Webview =====
          WebViewWidget(controller: _webviewController),
          // ===== Text Status =====
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Count: $_currentCount',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentCount = 0;
                      });
                      // _webviewController.loadRequest(
                      //   Uri.parse(_api_url),
                      // );
                    },
                    child: const Text(
                      "Refresh",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
