import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

class GotitsHelper {
  static List<String>? _features;

  static Future<List<String>> featureList(
      {bool notUsingHydratedStorage = false}) async {
    if (_features == null) {
      if (notUsingHydratedStorage) {
        _features = [];
      } else {
        String? gotitList = await fca.localStorage_read('gotits');
        _features =
            gotitList?.substring(1, gotitList.length - 1).split(',').toList() ?? [];
      }
    }
    return _features!;
  }

  static Future<void> gotit(String feature,
      {bool notUsingHydratedStorage = false}) async {
    List<String> features =
        await featureList(notUsingHydratedStorage: notUsingHydratedStorage);
    if (!features.contains(feature)) {
      _features ?? [].add(feature);
      fca.localStorage_write('gotits', features.toString());
    }
  }

  static Future<bool> alreadyGotit(int feature,
      {bool notUsingHydratedStorage = false}) async {
    List<String> features =
        await featureList(notUsingHydratedStorage: notUsingHydratedStorage);
    return features.contains(feature);
  }

  static Future<void> clearGotits(
      {bool notUsingHydratedStorage = false}) async {
    if (!notUsingHydratedStorage) {
      fca.localStorage_delete('gotits');
    }
    _features?.clear();
    // debugPrint("GotitsHelper.clearGotits");
  }

  static Widget gotitButton(
          {required String feature,
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
