// lib/navigation_service.dart or lib/app_keys.dart
import 'package:flutter/widgets.dart';

/// A global key for accessing the [NavigatorState] of the root [MaterialApp].
///
/// This key can be used by services or other parts of the app to navigate
/// or show dialogs without needing a [BuildContext] from the widget tree
/// where the navigation action is initiated.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();