import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin GotitsMixin {

  Future<void> gotit(String feature,
      {bool notUsingHydratedStorage = false}) async {
    List<String> gotits = fca.localStorage.read('gotits') ?? [];
    if (!gotits.contains(feature)) {
      gotits.add(feature);
      await fca.localStorage.write('gotits', gotits);
    }
  }

  bool alreadyGotit(String feature, {bool notUsingHydratedStorage = false}) =>
      (fca.localStorage.read('gotits') ?? []).contains(feature);

  Future<void> clearGotits({bool notUsingHydratedStorage = false}) async {
    fca.localStorage.delete('gotits');
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
