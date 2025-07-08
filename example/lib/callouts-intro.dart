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
  @override
  void didChangeDependencies() {
    fca.initWithContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('Toasts demo'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ToastDemoPage())),
          ),
        ],
      ),
    ),
    body: Center(
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
              textScaler: TextScaler.linear(2.0),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'This Flutter API can be used to create flutter overlays (callouts) that can be shown over your app\n\n',
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
                  ),

                  TextSpan(
                    text: "Callouts are great for popping up messages (toasts etc), and for highlighting or pointing stuff out.\n\n",
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
                  ),

                  TextSpan(
                    text:
                    "Flutter apps tend to have much more functionality, so adding callouts can really help your users learn about your app faster.\n\n",
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
                  ),

                  TextSpan(
                    text: "The API is quite comprehensive. Here are a series of demos to show off the package's capabilities...",
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToastDemoPage())),
                      child: Text('Toasts demo'),
                    ),
                    SizedBox(height: 20),
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
                  ],
                ),
              ),
            ),
            Spacer(),
            Text(
              "\n\nBTW - We also offer another pkg, built on top of this one, that extends this API with an accompanying admin UI. It makes it easy to create, configure, store as json, and publish to callouts your own editorial content (text, images, files, videos, polls etc). All the widgets delivered are flutter's own, or 3rd party widgets from pub.dev.",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}
