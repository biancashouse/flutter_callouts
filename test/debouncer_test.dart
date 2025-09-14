import 'package:fake_async/fake_async.dart' show fakeAsync;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_callouts/src/debouncer/debouncer.dart'; // Assuming DebounceTimer is in this file

void main() {
  group('DebounceTimer', () {
    test('action executes after specified delay', () {
      final debouncer = Debouncer(delayMs: 100);
      bool actionExecuted = false;

      // Use FakeAsync to control time
      fakeAsync((async) {
        debouncer.run(() {
          actionExecuted = true;
        });

        expect(actionExecuted, isFalse, reason: 'Action should not execute immediately.');
        async.elapse(const Duration(milliseconds: 50));
        expect(actionExecuted, isFalse, reason: 'Action should not execute before delay has passed.');
        async.elapse(const Duration(milliseconds: 50)); // Total 100ms
        expect(actionExecuted, isTrue, reason: 'Action should execute after delay has passed.');
      });
    });

    test('debounces rapid calls, only executing the last action', () {
      final debouncer = Debouncer(delayMs: 100);
      int executionCount = 0;
      int lastActionId = 0;

      fakeAsync((async) {
        // Call run multiple times quickly
        debouncer.run(() {
          executionCount++;
          lastActionId = 1;
        });
        async.elapse(const Duration(milliseconds: 10)); // Not enough time for action 1 to run

        debouncer.run(() {
          executionCount++;
          lastActionId = 2;
        });
        async.elapse(const Duration(milliseconds: 10)); // Not enough time for action 2 to run

        debouncer.run(() {
          executionCount++;
          lastActionId = 3;
        });

        // Wait for the debounce period of the last call
        async.elapse(const Duration(milliseconds: 100));

        expect(executionCount, 1, reason: 'Action should only execute once.');
        expect(lastActionId, 3, reason: 'Only the last action should have executed.');

        // Ensure no more executions happen after
        async.elapse(const Duration(milliseconds: 200));
        expect(executionCount, 1, reason: 'Action should not execute again.');
      });
    });

    test('cancel prevents action execution', () {
      final debouncer = Debouncer(delayMs: 100);
      bool actionExecuted = false;

      fakeAsync((async) {
        debouncer.run(() {
          actionExecuted = true;
        });

        expect(actionExecuted, isFalse);
        async.elapse(const Duration(milliseconds: 50));
        expect(actionExecuted, isFalse);

        debouncer.cancel(); // Cancel before the delay is over

        async.elapse(const Duration(milliseconds: 50)); // Past original execution time
        expect(actionExecuted, isFalse, reason: 'Action should not execute if cancelled.');
      });
    });

    test('calling run after cancel executes the new action', () {
      final debouncer = Debouncer(delayMs: 100);
      int executedAction = 0; // 0: none, 1: first, 2: second

      fakeAsync((async) {
        debouncer.run(() {
          executedAction = 1;
        });
        async.elapse(const Duration(milliseconds: 50));
        debouncer.cancel();
        async.elapse(const Duration(milliseconds: 50)); // First action should not have run
        expect(executedAction, 0, reason: "First action was cancelled, should not run.");

        // Run a new action
        debouncer.run(() {
          executedAction = 2;
        });
        async.elapse(const Duration(milliseconds: 100)); // Wait for the second action
        expect(executedAction, 2, reason: "Second action should run after being scheduled post-cancel.");
      });
    });

    test('multiple DebounceTimer instances operate independently', () {
      final debouncer1 = Debouncer(delayMs: 100);
      final debouncer2 = Debouncer(delayMs: 150);
      bool action1Executed = false;
      bool action2Executed = false;

      fakeAsync((async) {
        debouncer1.run(() {
          action1Executed = true;
        });
        debouncer2.run(() {
          action2Executed = true;
        });

        expect(action1Executed, isFalse, reason: "Action 1 shouldn't execute immediately.");
        expect(action2Executed, isFalse, reason: "Action 2 shouldn't execute immediately.");

        async.elapse(const Duration(milliseconds: 100));
        expect(action1Executed, isTrue, reason: "Action 1 should execute after 100ms.");
        expect(action2Executed, isFalse, reason: "Action 2 shouldn't execute yet (150ms delay).");

        async.elapse(const Duration(milliseconds: 50)); // Total 150ms
        expect(action2Executed, isTrue, reason: "Action 2 should execute after 150ms.");
      });
    });

  });
}
