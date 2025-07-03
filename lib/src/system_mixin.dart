// ignore_for_file: constant_identifier_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import 'logger_filter.dart';

mixin SystemMixin {
  String? _deviceInfo;
  PlatformEnum? _platform;
  Logger logger = Logger(
    filter: MyFilter(),
    printer: PrettyPrinter(
      colors: true,
      printEmojis: false,

    ),
  );
  final Logger loggerNs = Logger(
    filter: MyFilter(),
    printer: PrettyPrinter(methodCount: 6),
  );

  bool get isWeb => kIsWeb;

  bool get isAndroid => UniversalPlatform.isAndroid;

  bool get isIOS => UniversalPlatform.isIOS;

  bool get isMac => UniversalPlatform.isMacOS;

  bool get isWindows => UniversalPlatform.isWindows;

  bool get isFuchsia => UniversalPlatform.isFuchsia;

  String? get deviceInfo => _deviceInfo;

  PlatformEnum? get platform => _platform;

  void initDeviceInfoAndPlatform() {
    if (_deviceInfo == null) {
      try {
        if (kIsWeb) {
          _deviceInfo = 'web browser';
          _platform = PlatformEnum.web;
        } else if (UniversalPlatform.isAndroid) {
          DeviceInfoPlugin().androidInfo.then((info) {
            _deviceInfo = info.brand; //'${info.manufacturer} ${info.model}';
            _platform = PlatformEnum.android;
          });
        } else if (UniversalPlatform.isIOS) {
          DeviceInfoPlugin().iosInfo.then((info) {
            _deviceInfo = info.model; //'${info.model}';
            _platform = PlatformEnum.ios;
          });
        } else if (UniversalPlatform.isWindows) {
          _deviceInfo = 'Windows';
          _platform = PlatformEnum.windows;
        }
      } on Exception {
        _deviceInfo = 'not-android-nor-ios-nor-windows';
      }
    }
  }

  Future<bool> canInformUserOfNewVersion() async {
    // decide whether new version loaded
    // var box = Hive.box(await yamlAppName);
    String? storedVersionAndBuild = (await fca.localStorage).read("versionAndBuild");
    String latestVersionAndBuild = '$yamlVersion-$yamlBuildNumber';
    if (latestVersionAndBuild != (storedVersionAndBuild ?? '')) {
      (await fca.localStorage).write('versionAndBuild', latestVersionAndBuild);
      if (storedVersionAndBuild != null) return true;
    }
    return false;
  }

  bool _skipAssetPkgName =
      false; // when using assets from within the flutter_content pkg itself

  bool get skipAssetPkgName => _skipAssetPkgName;

  void setSkipAssetPkgNameTrue() => _skipAssetPkgName = true;

  Future<PackageInfo> get pkgInfo async => await PackageInfo.fromPlatform();

  Future<String> get yamlAppName async => (await pkgInfo).appName;

  Future<String> get yamlBuildNumber async => (await pkgInfo).buildNumber;

  Future<String> get yamlPackageName async => (await pkgInfo).packageName;

  Future<String> get yamlVersion async => (await pkgInfo).version;

  Future<String> get versionAndBuild async {
    var ver = await yamlVersion;
    var buildNum = await yamlBuildNumber;
    return buildNum.isEmpty ? ver : '$ver-$buildNum';
  }

// https://github.com/flutter/flutter/issues/25827 ---------------------------
  Widget androidAwareBuild(BuildContext context, Widget pageWidget) =>
      FutureBuilder<double?>(
          future: _whenNotZero(
            Stream<double>.periodic(const Duration(milliseconds: 50),
                (_) => MediaQuery.sizeOf(context).width),
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData && (snapshot.data ?? 0) > 0) {
              return pageWidget;
            }
            return const CircularProgressIndicator(
              color: Colors.orange,
            );
          });

  Future<double?> _whenNotZero(Stream<double> source) async {
    await for (double value in source) {
      if (value > 0) {
        return value;
      }
    }
    return null;
    // stream exited without a true value, maybe return an exception.
  }

// https://github.com/flutter/flutter/issues/25827 ---------------------------

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  /// Note, on iOS if an app has no buildNumber specified this property will return version
  /// Docs about CFBundleVersion: https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleversion

  void afterNextBuildDo(VoidCallback fn, {bool maintainSCOffsets = false}) {
    // Map<ScrollController, double> savedOffsets = maintainSCOffsets
    // ? saveScrollOffsets()
    // : {};
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // restoreScrollOffsets(savedOffsets);
      fn.call();
    });
  }

  Future afterMsDelayDo(int millis, VoidCallback fn,
      {bool maintainSCOffsets = false}) async {
    // Map<ScrollController, double> savedOffsets = maintainSCOffsets
    //     ? saveScrollOffsets()
    //     : {};
    Future.delayed(Duration(milliseconds: millis), () {
      // restoreScrollOffsets(savedOffsets);
      fn.call();
    });
  }

  // Map<ScrollController, double> saveScrollOffsets() {
  //   Map<ScrollController, double> offsets = {};
  //   for (ScrollController sC in NamedScrollController.allControllers()) {
  //     if (sC.positions.isNotEmpty) {
  //       offsets[sC] = sC.offset;
  //     }
  //   }
  //   return offsets;
  // }

  // void restoreScrollOffsets(Map<ScrollController, double> offsets) {
  //   if (offsets.isNotEmpty) {
  //     for (ScrollController sC in offsets.keys.toList()) {
  //       if (sC.hasClients) {
  //         double offset = offsets[sC]!;
  //         sC.jumpTo(offset);
  //       }
  //     }
  //   }
  // }

  // Logger pkg ---------------------------------------------------------------

// formattedDate(int ms) => DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(ms));
  formattedDate(int ms) =>
      DateFormat('MMMMd').format(DateTime.fromMillisecondsSinceEpoch(ms));

  String removeNonNumeric(s) => s.replaceAll(RegExp(r"\D"), "");
}


enum PlatformEnum { android, ios, web, windows, osx, fuchsia, linux }

const Duration ms300 = Duration(milliseconds: 300);
const Duration ms500 = Duration(milliseconds: 500);
const Duration immediate = Duration(milliseconds: 0);
