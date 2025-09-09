import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_callouts_example/toast_demo.dart';

import 'callout_following_scroll_demo.dart';
import 'callout_with_barrier_demo.dart';
import 'callout_with_pointer_demo.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => IntroPageState();
}

/// it's important to add the mixin, because callouts are animated
class IntroPageState extends State<IntroPage> {

  double get fontSize {
    double result = fca.scrW < 600 ? 12.0 : 18.0;
    return result;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: fca.scrW * .6,
            height: fca.scrH * .95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Welcome to the flutter_callouts pkg demo\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaler: TextScaler.linear(1.4),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'This Flutter API can be used to create flutter overlays (callouts) that can be shown over your app\n\n',
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: fontSize),
                      ),
        
                      TextSpan(
                        text: "Callouts are great for highlighting or pointing stuff out, or for popping up messages (toasts etc).\n\n",
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: fontSize),
                      ),
        
                      TextSpan(
                        text:
                        "Flutter apps tend to have much more functionality, so adding callouts can really help declutter the ui,\nand help your users understand your app faster.\n\n",
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: fontSize),
                      ),
        
                      TextSpan(
                        text: "The API is quite comprehensive. Here are a series of demos to show off the package's capabilities...\n",
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: fontSize),
                      ),
                    ],
                  ),
                ),
        
                IntrinsicHeight(
                    child: Column(
                      children: [
                        FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ScrollingDemo())),
                          child: Text('Simple callout demo'),
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BarrierDemo())),
                          child: Text('Barrier demo'),
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PointerDemo())),
                          child: Text('Target Pointer demo'),
                        ),
                        SizedBox(height: 20),
                        FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToastDemoPage())),
                          child: Text('Toasts demo'),
                        ),
                      ],
                    ),
                  ),
                Spacer(),
                Text(
                  "\n\nBTW - We also offer another pkg (flutter_content), "
                      "built on top of this one, "
                      "that extends this API with an accompanying admin UI. It "
                      "makes it easy to configure your callouts and store "
                      "those configurations as json in firestore, and also to"
                      " publish in the callouts your own editorial content "
                      "(text, images, files, videos, polls etc)"
                      " in real time from your firestore database.",
                  style: TextStyle(fontSize: 9),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
