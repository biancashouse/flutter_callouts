import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

mixin GotitsMixin {

  static bool initCalled = false;
  static List<String> gotits = const [];

  Future<void> initGotits() async {
    if (initCalled) return;
    initCalled = true;
    (await fca.localStorage).read('gotits') ?? [];
  }

  Future<void> gotit(String feature,
      {bool notUsingHydratedStorage = false}) async {
    assert(initCalled, "Didn't call initGotits() !");
    if (!gotits.contains(feature)) {
      gotits.add(feature);
      (await fca.localStorage).write('gotits', gotits);
    }
  }

  /// assumes initGotits called
  bool alreadyGotit(String feature, {bool notUsingHydratedStorage = false}) {
    assert(initCalled, "Didn't call initGotits() !");
    return (fca.localStorage.read('gotits') ?? []).contains(feature);
  }

  Future<void> clearGotits({bool notUsingHydratedStorage = false}) async {
    (await fca.localStorage).delete('gotits');
    gotits.clear();
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
