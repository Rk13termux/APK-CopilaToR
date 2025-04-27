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
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const YouTubeChannelScreen(),
    );
  }
}

class YouTubeChannelScreen extends StatefulWidget {
  const YouTubeChannelScreen({super.key});

  @override
  State<YouTubeChannelScreen> createState() => _YouTubeChannelScreenState();
}

class _YouTubeChannelScreenState extends State<YouTubeChannelScreen> {
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri("https://www.youtube.com/@AudioBlazePro"),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false, // 🔥 Clave para que el audio siga con pantalla apagada
                allowsInlineMediaPlayback: true,
                preferredContentMode: UserPreferredContentMode.MOBILE,
                supportZoom: true,
                clearSessionCache: false,
                allowsBackForwardNavigationGestures: true,
                useShouldOverrideUrlLoading: true,
                thirdPartyCookiesEnabled: true,
                userAgent: "Mozilla/5.0 (Linux; Android 10; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0",
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onProgressChanged: (controller, newProgress) {
                setState(() {
                  progress = newProgress / 100;
                });
              },
            ),
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                color: Colors.redAccent,
                backgroundColor: Colors.black,
                minHeight: 2,
              ),
          ],
        ),
      ),
    );
  }
}
