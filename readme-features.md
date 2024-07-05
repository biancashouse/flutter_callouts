## Features

The Callout API makes it easy for you to point out **target** widgets by showing **callout** widgets.

How a **callout** appears, and interacts with the user is highly configurable.

#### Simple API
- the **target** must have a *GlobalKey*.
- the **callout** must be given a string cId.
- the **callout** requires you to supply the content widget.

- decoupled from your UI
A callout, or toast, is shown in a Flutter Overlay, so does not interfere with your UI.

#### Extremely Configurable

- Every aspect of showing a callout is configurable, in terms of styling, pointing style, draggability, resizability, animation, duration on screen, and more...

  - #### Callout and pointer styling
    Color, shape, decoration, border of callouts is configurable.
    You can configure how your callout points to its Target, such as line with arrow, or bubble shape, and the distance it should be separated from the Target.

  - #### animated
    Appearance is animated, and the pointer to the target can be animated
  
  - #### user draggable
    Callouts can optionally be dragged. You can assign just part of the callout as a drag handle.

  - #### user resizable
    A callout can optionally be surrounded by 4 corner and 4 side resize widgets, i.e. the user can resize a callout by dragging a corner or a side.
  
  - #### tappable barrier
    A callout can have an optional tappable barrier behind. (tap off the callout to close it, otherwise you can configure a close button)

  - #### close button 
    A close button is optional. Its callback, and appearance are configurable.
  
    A callout can also be dismissed, hidden/unhidden using the API.

  - #### got it button
    A callout can be configured to show a "got it" button.

    The tap will get recorded in the Browser or App's local storage (using the callout's id).

  - #### scroll-aware
    If you pass your ScrollController to the API, a callout can continue to point to its Target even when scrolling occurs, the window is resized.

  - #### decoupled, non-intrusive API
    Any widget can be a Target: simply give it a GlobalKey.
  
    No need to insert wrapper widgets in your UI.

    Each callout gets shown in its own Overlay.

  - #### useful callbacks
  
    Every possible callback is provided to allow your app to react to a callout's activity:
  
```dart
        ValueNotifier<int>? movedOrResizedNotifier; // bumps every time callout overlay moved or resized
        Function? onGotitPressedF;
        VoidCallback? CalloutBarrier.onTapped;
        VoidCallback? onCloseButtonPressF;
        ValueChanged<Offset>? onDragF;
        VoidCallback? onDragStartedF;
        ValueChanged<Offset>? onDragEndedF;
        ValueChanged<Size>? onResizeF;
        VoidCallback? onDismissedF;
        VoidCallback? onHiddenF;
        VoidCallback? onAcceptedF;
```