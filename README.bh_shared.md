<!-- This file uses generated code. Visit https://pub.dev/packages/readme_helper for usage information. -->
# bh_shared (package functionality is relocated to another package)

# *** this library defunct: now rolled into flutter_callout package ***
#
#

<!-- #include 1.readme-intro.md -->
A collection of useful APIs and flutter widgets that are used in our other packages:

- flutter_callouts
- flutter_content

Hopefully, they may be useful for you in your apps.
<!-- // end of #include -->

<!-- #include readme-motivation.md -->
## Motivation

It's sensible to centralise your reusable source code into a separate library.
<!-- // end of #include -->

<!-- #include readme-features.md -->
## Features
- a local storage API
- gotits API (based on local storage)
- debounce timer
- some useful widgets
<!-- // end of #include -->

<!-- #include readme-quickstart.md -->
## Quickstart

**1.** Install or update package **bh_shared**:
```bash
flutter pub add bh_shared
```

- How to include in your apps
  you can add the functionality of the API to your own dart classes using the *with* keyword.

```dart
class MyClass with SystemMixin, WidgetHelperMixin, GotitsMixin, LocalStorageMixin, CanvasMixin {}
```
Or, for your convenience, simply prefix any method with __base.__
<!-- // end of #include -->

<!-- #toc -->
## Table of Contents

[**Motivation**](#motivation)

[**Features**](#features)

[**Quickstart**](#quickstart)

[**Usage**](#usage)
- [Local Storage API](#local-storage-api)
- [Gotits API](#gotits-api)
- [Debouncer API](#debouncer-api)
- [Miscellaneous useful widgets and methods we found useful](#miscellaneous-useful-widgets-and-methods-we-found-useful)
<!-- // end of #toc -->

<!-- #include readme-usage.md -->
## Usage
### Local Storage API

Local storage refers to browser storage on web, and device storage on mobile.

```dart
  Future<void> localStorage_init() async {}

  dynamic localStorage_read(String name) {}

  Future<void> localStorage_write(String name, dynamic value) async {}

  void localStorage_clear() {}

  void localStorage_delete(String name) {}
```

### Gotits API

This API is useful if you want to allow the user to specify that help has been seen and to not show again.
A map of named booleans is stored in local storage.
Also a useful widget is provided.

```dart
Future<void> gotit(String feature, {bool notUsingHydratedStorage = false})

bool alreadyGotit(String feature, {bool notUsingHydratedStorage = false})

void clearGotits({bool notUsingHydratedStorage = false})

Widget gotitButton({required String feature,
  required double iconSize,
  bool notUsingHydratedStorage = false})
```

### Debouncer API

An instance of DebounceTimer is useful for timing out events, such as repeated keypresses:

```dart
    class DebounceTimer {
      int delayMs;
      Timer? _timer;
    
      DebounceTimer({required this.delayMs});
    
      void run(VoidCallback action) {
        _timer?.cancel();
        _timer = Timer(Duration(milliseconds: delayMs), action);
      }
    
      void cancel() {
        _timer?.cancel();
      }
    }
```

# Issues & Feedback
Please file an [issue](https://github.com/biancashouse/bh_shared/issues) to send feedback or report a bug. Thank you!