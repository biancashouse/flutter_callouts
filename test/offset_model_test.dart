import 'package:flutter_callouts/src/api/callouts/model/offset_model.dart'
    show OffsetModel;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OffsetModel Tests', () {
    // --- Constructor Tests ---
    group('Constructors', () {
      test('Default constructor should correctly initialize dx and dy', () {
        const offset = OffsetModel(10.5, -5.25);
        expect(offset.dx, 10.5);
        expect(offset.dy, -5.25);
      });

      test('Named constructor "zero" should initialize dx and dy to 0.0', () {
        final offset = OffsetModel.zero();
        expect(offset.dx, 0.0);
        expect(offset.dy, 0.0);
      });
    });

    // --- Equality (operator ==) and HashCode Tests ---
    group('Equality and HashCode', () {
      test('Instances with same dx and dy should be equal', () {
        const offset1 = OffsetModel(1.0, 2.0);
        const offset2 = OffsetModel(1.0, 2.0);
        expect(offset1 == offset2, isTrue);
      });

      test('Instances with different dx should not be equal', () {
        const offset1 = OffsetModel(1.0, 2.0);
        const offset2 = OffsetModel(1.5, 2.0);
        expect(offset1 == offset2, isFalse);
      });

      test('Instances with different dy should not be equal', () {
        const offset1 = OffsetModel(1.0, 2.0);
        const offset2 = OffsetModel(1.0, 2.5);
        expect(offset1 == offset2, isFalse);
      });

      test('An instance should be equal to itself', () {
        const offset = OffsetModel(3.0, 4.0);
        expect(offset == offset, isTrue);
      });

      test('Should not be equal to an instance of a different type', () {
        const offset = OffsetModel(1.0, 1.0);
        const otherType = "SomeString";
        expect(offset == otherType, isFalse);
      });

      test('Equal instances should have the same hashCode', () {
        const offset1 = OffsetModel(10.0, 20.0);
        const offset2 = OffsetModel(10.0, 20.0);
        expect(offset1.hashCode, equals(offset2.hashCode));
      });

      test(
          'OffsetModel.zero() should be equal to OffsetModel(0.0, 0.0) and have same hashCode',
          () {
        final zeroOffset = OffsetModel.zero();
        const explicitZeroOffset = OffsetModel(0.0, 0.0);
        expect(zeroOffset == explicitZeroOffset, isTrue);
        expect(zeroOffset.hashCode, equals(explicitZeroOffset.hashCode));
      });

      test(
          'HashCode consistency: multiple calls on same object return same hash',
          () {
        const offset = OffsetModel(5.5, 6.6);
        final hash1 = offset.hashCode;
        final hash2 = offset.hashCode;
        expect(hash1, equals(hash2));
      });

      // Test for collections
      test('Equality works correctly in Sets', () {
        final offset1 = OffsetModel(1.0, 2.0);
        final offset2 = OffsetModel(1.0, 2.0); // Equal to offset1
        final offset3 = OffsetModel(3.0, 4.0); // Different

        final set = <OffsetModel>{offset1, offset2, offset3};
        expect(set.length, 2); // offset1 and offset2 are considered the same
        expect(set.contains(OffsetModel(1.0, 2.0)), isTrue);
        expect(set.contains(OffsetModel(3.0, 4.0)), isTrue);
        expect(set.contains(OffsetModel(5.0, 6.0)), isFalse);
      });

      test('Equality works correctly as Map keys', () {
        final offset1 = OffsetModel(1.0, 2.0);
        final offset2 = OffsetModel(1.0, 2.0); // Equal to offset1
        final offset3 = OffsetModel(3.0, 4.0); // Different

        final map = <OffsetModel, String>{
          offset1: 'value1',
          offset3: 'value3',
        };
        //Adding offset2 should update the value for the key equivalent to offset1
        map[offset2] = 'value2_updated';

        expect(map.length, 2);
        expect(map[OffsetModel(1.0, 2.0)], 'value2_updated');
        expect(map[OffsetModel(3.0, 4.0)], 'value3');
      });
    });

    // --- translate() Method Tests ---
    group('translate()', () {
      test('Should correctly translate dx and dy by given values', () {
        const initial = OffsetModel(10.0, 20.0);
        final translated = initial.translate(5.0, -10.0);
        expect(translated.dx, 15.0);
        expect(translated.dy, 10.0);
      });

      test('Translating by zero should result in an equal OffsetModel', () {
        const initial = OffsetModel(7.0, 3.0);
        final translated = initial.translate(0.0, 0.0);
        expect(
            translated, equals(initial)); // Checks for equality, not identity
        expect(translated.dx, 7.0);
        expect(translated.dy, 3.0);
      });

      test('Translate should return a new instance (immutability)', () {
        const initial = OffsetModel(1.0, 1.0);
        final translated = initial.translate(1.0, 1.0);
        expect(identical(initial, translated), isFalse);
      });
    });
  });
}
