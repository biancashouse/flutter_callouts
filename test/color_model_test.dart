import 'package:flutter/material.dart'; // For Color and Colors
import 'package:flutter_callouts/src/api/callouts/model/color_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorModel Tests', () {
    // --- Equality (operator ==) and HashCode Tests ---
    group('Equality and HashCode', () {
      final redColor = ColorModel.fromColor(Colors.red);
      final blueColor = ColorModel.fromColor(Colors.blue);
      final redColor2 =
          ColorModel(Colors.red.a, Colors.red.r, Colors.red.g, Colors.red.b);
      final someColor = Color(0xFFABCDEF);
      final color1 = ColorModel.fromColor(someColor);
      final color2 =
          ColorModel(someColor.a, someColor.r, someColor.g, someColor.b);
      final color3 =
          ColorModel(someColor.a, someColor.r, someColor.g, someColor.b + 1);

      test('equality', () {
        expect(color1 == color2, isTrue);
        expect(redColor == redColor2, isTrue);
        expect(redColor == blueColor, isFalse);
        expect(color1 == color2, isTrue);

      });

      test('Should not be equal to an instance of a different type', () {
        expect(color1 == "A String", isFalse);
      });

      test('Equal instances should have the same hashCode', () {
        expect(color1.hashCode, equals(color2.hashCode));
      });

      test('HashCode consistency', () {
        expect(color1.hashCode, equals(color1.hashCode));
      });

      test('Different instances should ideally have different hashCodes', () {
        // Note: Hash collisions are possible but unlikely for simple distinct objects.
        // This test is more of a sanity check.
        expect(color1.hashCode, isNot(equals(color3.hashCode)));
      });
    });
  });
}
