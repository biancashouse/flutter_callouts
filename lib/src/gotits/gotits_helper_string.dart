// import 'package:flutter/material.dart';
// import 'package:flutter_callouts/flutter_callouts.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
//
// class GotitsHelper {
//   static List<String>? _features;
//
//   static List<String> features({bool notUsingHydratedStorage = false}) {
//     //debugPrint(_features.toString());
//
//     if (_features == null) {
//       if (notUsingHydratedStorage) {
//         _features = [];
//       } else {
//         String? gotitList = CalloutUseful().browserStorage_read('gotits');
//         _features = gotitList?.substring(1, gotitList.length - 1).split(',').toList() ?? [];
//       }
//     }
//     // prString("GotitsHelper.features");
//     return _features!;
//   }
//
//   static void gotit(String theFeatureIndex, {bool notUsingHydratedStorage = false}) {
//     if (!features(notUsingHydratedStorage:notUsingHydratedStorage).contains(theFeatureIndex)) {
//       features(notUsingHydratedStorage:notUsingHydratedStorage).add(theFeatureIndex);
//       HydratedBloc.storage.write('gotits', features(notUsingHydratedStorage:notUsingHydratedStorage).toString());
//     }
//     // debugPrint("GotitsHelper.gotit");
//   }
//
//   static bool alreadyGotit(String feature, {bool notUsingHydratedStorage = false}) {
//     // debugPrint("GotitsHelper.alreadyGotit");
//     return features(notUsingHydratedStorage:notUsingHydratedStorage).contains(feature);
//   }
//
//   static void clearGotits({bool notUsingHydratedStorage = false}) {
//     if (!notUsingHydratedStorage) HydratedBloc.storage.delete('gotits');
//     features(notUsingHydratedStorage:notUsingHydratedStorage).clear();
//     // debugPrint("GotitsHelper.clearGotits");
//   }
//
//   static Widget gotitButton({required String feature, required double iconSize, bool notUsingHydratedStorage = false}) => IconButton(
//         onPressed: () {
//           gotit(feature, notUsingHydratedStorage:notUsingHydratedStorage);
//         },
//         icon: const Icon(Icons.thumb_up),
//         iconSize: iconSize,
//       );
// }
