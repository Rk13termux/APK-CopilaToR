import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AudioBlazeProApp());
}

class AudioBlazeProApp extends StatelessWidget {
  const AudioBlazeProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AudioBlazePro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFF0000),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const YouTubeWebView(),
    );
  }
}

class YouTubeWebView extends StatefulWidget {
  const YouTubeWebView({super.key});

  @override
  State<YouTubeWebView> createState() => _YouTubeWebViewState();
}

class _YouTubeWebViewState extends State<YouTubeWebView> {
  InAppWebViewController? webViewController;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri("https://www.youtube.com/"),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                allowsInlineMediaPlayback: true,
                mediaPlaybackRequiresUserGesture: false,
                supportZoom: true,
                thirdPartyCookiesEnabled: true,
                clearSessionCache: false,
                useOnDownloadStart: true,
                allowsBackForwardNavigationGestures: true,
                preferredContentMode: UserPreferredContentMode.MOBILE,
                userAgent: "Mozilla/5.0 (Linux; Android 10; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0",
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onLoadError: (controller, url, code, message) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text('Error de carga', style: TextStyle(color: Colors.red)),
                    content: const Text('No se pudo cargar YouTube. Verifique su conexión a Internet.', style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.reload();
                        },
                        child: const Text('Reintentar', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_progress < 1.0)
              LinearProgressIndicator(
                value: _progress,
                color: Colors.red,
                backgroundColor: Colors.black,
                minHeight: 2,
              ),
          ],
        ),
      ),
    );
  }
}
