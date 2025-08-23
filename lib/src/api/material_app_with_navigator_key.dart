// lib/widgets/global_material_app.dart (or similar)
import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A custom [MaterialApp] wrapper that automatically instantiates and uses
/// a global [navigatorKey].
///
/// This simplifies setting up global navigation access. All parameters of
/// the standard [MaterialApp] are exposed.
class FlutterCalloutsApp extends HookWidget {
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
  const FlutterCalloutsApp({
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

  /// Creates a [MaterialApp] that would use a Router
  /// advice: This pkg doesn't make use of a router. Use the flutter_content pkg if you want to have multiple Go_Router routes.
  /// That's why this .router constructor is commented out
  // const FlutterCalloutsApp.router({
  //   super.key,
  //   this.scaffoldMessengerKey,
  //   this.routeInformationProvider,
  //   this.routeInformationParser,
  //   this.routerDelegate,
  //   this.routerConfig,
  //   this.backButtonDispatcher,
  //   this.builder,
  //   this.title = '',
  //   this.onGenerateTitle,
  //   this.color,
  //   this.theme,
  //   this.darkTheme,
  //   this.highContrastTheme,
  //   this.highContrastDarkTheme,
  //   this.themeMode = ThemeMode.system,
  //   this.themeAnimationDuration = kThemeAnimationDuration,
  //   this.themeAnimationCurve = Curves.linear,
  //   this.locale,
  //   this.localizationsDelegates,
  //   this.localeListResolutionCallback,
  //   this.localeResolutionCallback,
  //   this.supportedLocales = const <Locale>[Locale('en', 'US')],
  //   this.debugShowMaterialGrid = false,
  //   this.showPerformanceOverlay = false,
  //   this.checkerboardRasterCacheImages = false,
  //   this.checkerboardOffscreenLayers = false,
  //   this.showSemanticsDebugger = false,
  //   this.debugShowCheckedModeBanner = true,
  //   this.shortcuts,
  //   this.actions,
  //   this.restorationScopeId,
  //   this.scrollBehavior,
  //   this.useInheritedMediaQuery = false,
  // })  : navigatorObservers = const <NavigatorObserver>[], // Not used by router
  //       home = null,
  //       routes = const <String, WidgetBuilder>{},
  //       initialRoute = null,
  //       onGenerateRoute = null,
  //       onGenerateInitialRoutes = null,
  //       onUnknownRoute = null,
  //       assert(routerDelegate != null || routerConfig != null);

  @override
  Widget build(BuildContext context) {
    // 1. State to track if initialization is complete
    final isInitialized = useState(false);
    // Optional: State to track if there was an error during initialization
    final initializationError = useState<Object?>(null);

    // 2. useEffect to run the initialization logic once
    useEffect(() {
      // This async self-invoking function runs the initialization
      Future<void> initialize() async {
        try {
          await fca.initLocalStorage();
          fca.loggerNs.i('await fca.initLocalStorage();');
          fca.loggerNs.w('Just a warning!');
          fca.logger.e('Error! Something bad happened', error: 'Test Error');
          fca.loggerNs.t({'key': 5, 'value': 'something'});
          isInitialized.value = true;   // Set state to true after completion
        } catch (e) {
          initializationError.value = e; // Store error if any
          // You might want to log the error as well
          debugPrint('Error during initLocalStorage: $e');
        }
      }

      initialize();

      // useEffect can return a cleanup function, but it's not needed here
      // if initLocalStorage doesn't require explicit teardown.
      return null;
    }, const []); // Empty list `[]` means this effect runs only once after the first build.

    // 3. Conditionally render UI based on initialization state
    if (initializationError.value != null) {
      // Optional: Show an error message if initialization failed
      return Center(
        child: Text(
          'Failed to initialize: ${initializationError.value}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (!isInitialized.value) {
      // While not initialized, show a loading indicator
      return const Center(child: CircularProgressIndicator());
    }

    // Once initialized, build your actual widget content
    return _build(context);
  }

  Widget _build(BuildContext context) {
    // Determine if we are using the router constructor or the navigator constructor
    final bool usesRouter = routerDelegate != null || routerConfig != null;

    if (usesRouter) {
      return MaterialApp.router(
        key: super.key,
        // navigatorKey is NOT used by MaterialApp.router,
        // instead you have to pass fca.globalNavigatorKey to the
        // GoRouter.routingConfig() constructor
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
