// lib/widgets/global_material_app.dart (or similar)
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

/// A custom [MaterialApp] wrapper that automatically instantiates and uses
/// a global [navigatorKey].
///
/// This simplifies setting up global navigation access. All parameters of
/// the standard [MaterialApp] are exposed.
class FC_MaterialApp extends StatelessWidget {
  // Expose all the parameters you normally use for MaterialApp
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Widget? home;
  final Map<String, WidgetBuilder> routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Duration themeAnimationDuration;
  final Curve themeAnimationCurve;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool debugShowMaterialGrid;
  final bool useInheritedMediaQuery;

  // Router specific parameters
  final RouterDelegate<Object>? routerDelegate;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouteInformationProvider? routeInformationProvider;
  final RouterConfig<Object>? routerConfig;
  final BackButtonDispatcher? backButtonDispatcher;
  // Removed widget.key and passed it to super constructor instead
  const FC_MaterialApp({
    super.key, // Use super.key for the widget itself
    this.scaffoldMessengerKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.debugShowMaterialGrid = false,
    this.useInheritedMediaQuery = false,
  })  : routerDelegate = null,
        routeInformationParser = null,
        routeInformationProvider = null,
        routerConfig = null,
        backButtonDispatcher = null;

  /// Creates a [GlobalMaterialApp] that uses the [Router] instead of a [Navigator].
  const FC_MaterialApp.router({
    super.key,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.themeAnimationDuration = kThemeAnimationDuration,
    this.themeAnimationCurve = Curves.linear,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery = false,
  })  : navigatorObservers = const <NavigatorObserver>[], // Not used by router
        home = null,
        routes = const <String, WidgetBuilder>{},
        initialRoute = null,
        onGenerateRoute = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        assert(routerDelegate != null || routerConfig != null);

  @override
  Widget build(BuildContext context) {
    // Determine if we are using the router constructor or the navigator constructor
    final bool usesRouter = routerDelegate != null || routerConfig != null;

    if (usesRouter) {
      return MaterialApp.router(
        key: super.key, // Use the widget's key for MaterialApp
        // navigatorKey is NOT used by MaterialApp.router
        scaffoldMessengerKey: scaffoldMessengerKey,
        routeInformationProvider: routeInformationProvider,
        routeInformationParser: routeInformationParser,
        routerDelegate: routerDelegate,
        routerConfig: routerConfig,
        backButtonDispatcher: backButtonDispatcher,
        builder: builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        color: color,
        theme: theme,
        darkTheme: darkTheme,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        themeMode: themeMode,
        themeAnimationDuration: themeAnimationDuration,
        themeAnimationCurve: themeAnimationCurve,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowMaterialGrid: debugShowMaterialGrid,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
      );
    } else {
      return MaterialApp(
        key: super.key, // Use the widget's key for MaterialApp
        navigatorKey: fca.globalNavigatorKey, // Crucially, assign the global key here
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: home,
        routes: routes,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers,
        builder: builder,
        title: title,
        onGenerateTitle: onGenerateTitle,
        theme: theme,
        darkTheme: darkTheme,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        themeMode: themeMode,
        themeAnimationDuration: themeAnimationDuration,
        themeAnimationCurve: themeAnimationCurve,
        color: color,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        actions: actions,
        restorationScopeId: restorationScopeId,
        scrollBehavior: scrollBehavior,
        debugShowMaterialGrid: debugShowMaterialGrid,
      );
    }
  }
}
