import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin GotitsMixin {

  Future<void> gotit(String feature,
      {bool notUsingHydratedStorage = false}) async {
    List<String> gotits = fca.spwc?.getStringList('gotits') ?? [];
    if (!gotits.contains(feature)) {
      gotits.add(feature);
      await fca.spwc?.setStringList('gotits', gotits);
    }
  }

  bool alreadyGotit(String feature, {bool notUsingHydratedStorage = false}) =>
      (fca.spwc?.getStringList('gotits') ?? []).contains(feature);

  void clearGotits({bool notUsingHydratedStorage = false}) {
    fca.spwc?.remove('gotits');
  }

  Widget gotitButton({required String feature,
    required double iconSize,
    bool notUsingHydratedStorage = false}) =>
      IconButton(
        onPressed: () {
          gotit(feature, notUsingHydratedStorage: notUsingHydratedStorage);
        },
        icon: const Icon(Icons.thumb_up),
        iconSize: iconSize,
      );
}
