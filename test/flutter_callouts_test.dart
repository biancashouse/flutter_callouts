import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_callouts/flutter_callouts.dart'; // This exports 'fca' and FlutterCalloutMixins

void main() {
  group('FlutterCalloutMixins Initialization', () {
    test('global `fca` instance is correctly initialized', () {
      // Verify that the global 'fca' instance is not null
      expect(fca, isNotNull, reason: 'The global `fca` instance should be non-null.');

      // Verify that 'fca' is an instance of FlutterCalloutMixins
      expect(fca, isA<FlutterCalloutMixins>(), reason: 'The global `fca` instance should be of type FlutterCalloutMixins.');
    });

    // Further tests for the functionalities provided by the individual mixins
    // that FlutterCalloutMixins combines (e.g., RootContextMixin, KeystrokesMixin,
    // MeasuringMixin, CalloutMixin, etc.) should be in their respective
    // dedicated test files (e.g., test/root_context_mixin_test.dart).

    // These dedicated test files will use the `fca` instance to access
    // the methods provided by the mixins. For example, in
    // `root_context_mixin_test.dart`, you might have:
    //
    // test('globalNavigatorKey returns a GlobalKey through fca', () {
    //   expect(fca.globalNavigatorKey, isA<GlobalKey<NavigatorState>>());
    // });
  });
}
