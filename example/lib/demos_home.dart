import 'package:example/demo_page_textf_overlayportal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

import 'demo_page_config_playground.dart';
import 'demo_page_textfield_overlay.dart';
import 'demo_page_animated_overlay.dart';

class CalloutDemosHome extends StatefulWidget {
  const CalloutDemosHome({super.key});

  @override
  State<CalloutDemosHome> createState() => _CalloutDemosHomeState();
}

class _CalloutDemosHomeState extends State<CalloutDemosHome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Flutter Callouts - Examples Home Page'),
            Text(
              'Each button takes you to a demo page.',
              textScaler: TextScaler.linear(.7),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              DemoPage_ConfigPlayground.demoLaunchBtn(context),
              DemoPage_TextFieldInAnOverlay.demoLaunchBtn(context),
              DemoPage_TextInAnOverlayPortal.demoLaunchBtn(context),
              DemoPage_AnimatedCallout.demoLaunchBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FCallouts().afterNextBuildDo((){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DemoPage_ConfigPlayground()),
      );
    });
  }
}
