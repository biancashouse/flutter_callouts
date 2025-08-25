# Point stuff out: Animated Callouts for Flutter

Whether you want simple popup windows, or callouts that point to a target widget, or toast popups, this API does it all.

Being able have your callout point to a **target** widget is a very potent tool for helping your the users understand and navigate your app. A callout overlay’s pointing line can follow its target widget  (by assigning the target a **GlobalKey**). 

| Web  | Android | iOS  | macOS | Windows | Linux  |
|------|---------|------|-------|---------|--------|
| yes  | todo    | todo | todo  | todo    | todo   |

* pop up a callout widget that points to a target widget  
  (positioning using 2 values: **initialCalloutAlignment** & **initialTargetAlignment**)

* pop up a callout widget that has no target, but can be positioned on the screen  
  (positioned using an absolute screen coord: **initialCalloutPos**)

* pop up a callout widget as a Toast, positioned by an alignment value named **gravity**

* make it easy to allow dragging and resizing of callouts

* allow callouts to optionally follow scroll

* allow configuration of all aspects of callouts

* make configuration serializable (json)

**The intro page leads to 4 demo pages**

![](https://github.com/biancashouse/flutter_callouts/blob/main/readme_images/intro_page.png?raw=true)

**Callout points out target widgets, and is draggable and can follow scroll**

![](https://github.com/biancashouse/flutter_callouts/blob/main/readme_images/dragging_and_scrolling.gif?raw=true)

**A barrier can be configured behind the callout, with a cutout for the target**

![](https://github.com/biancashouse/flutter_callouts/blob/main/readme_images/barrier_demo.gif?raw=true)

**The callout pointer can be configured, as well as a line label, and many other options**

![](https://github.com/biancashouse/flutter_callouts/blob/main/readme_images/pointer_demo.gif?raw=true)

**The callouts api can also be used to pop up toast from multiple directions**

![](https://github.com/biancashouse/flutter_callouts/blob/main/readme_images/toast_demo.gif?raw=true)


## Quick Start

To use this api, replace your use of **MaterialApp** with **FlutterCalloutsApp**, which actually creates a MaterialApp itself..

The **flutter\_callouts** package defines many classes, the most important of which are the following…

* **FlutterCalloutsApp** \- wraps your app.

* Global object **fca** \- you access the api using this global object
  (which is an instance of FlutterCalloutMixins).

You create a callout at runtime by calling the following method:

```dart
  fca.showOverlay(
        calloutConfig: ...,
        calloutContent: ...,
        targetGkF: ...,
      );
```

* **Serializable property classes and enums** used to configure callouts:
  * AlignmentEnum
  * ArrowTypeEnum
  * ColorModel
  * DecorationShapeEnum
  * OffsetModel
  * UpTo6Colors \- models a gradient

* **CalloutConfigModel** \- the serializable callout configuration object. Its constructor takes many args, most of which, hopefully, are aptly named to not require explanation:

```dart 
CalloutConfigModel({
  required this.cId,		// each callout has a unique id  
  this.callerGK,
  this.movedOrResizedNotifier,
  This.gravity,			// used for Toasts
  // "required" forces developer to consider scrolling
  required this.scrollControllerName,
  this.followScroll \= true,
  this.forceMeasure \= false,
  this.initialCalloutW,
  this.initialCalloutH,
  this.minWidth,
  this.minHeight,
  this.fillColor,
  this.decorationShape \= DecorationShapeEnum.rectangle,
  this.starPoints,		// used if callout shape is a star  
  this.circleShape \= false,
  this.noBorder \= false,
  this.borderColor,
  this.borderRadius \= 0,
  this.borderThickness \= 0,
  this.contentTranslateX,	// can offset the callout widget  
  this.contentTranslateY,
  this.targetTranslateX,	// can offset the target widget  
  this.targetTranslateY,
  this.arrowType \= ArrowTypeEnum.THIN,
  this.arrowColor,
  this.lengthDeltaPc \= 0.95,	// arrow length  
  this.animate \= false,	// animate the pointing line  
  this.toDelta,			// offset pointing line start  
  this.fromDelta,		// offset pointing line end  
  this.lineLabel,
  this.barrier,
  this.showCloseButton \= false,
  this.closeButtonPos \= const Offset(10, 10),
  this.onCloseButtonPressF,
  this.closeButtonColor \= Colors.red,
  this.initialTargetAlignment,	// used when pointing to a target widget  
  this.initialCalloutAlignment,	// used when pointing to a target widget  
  this.initialCalloutPos,	// used when no target widget to point to  
  this.frameTarget \= false,
  this.scaleTarget \= 1.0,
  this.elevation \= 0,		// callout elevation  
  this.dragHandleHeight,
  this.draggable \= true,
  this.canToggleDraggable \= false,
  this.onDragF,
  this.onDragEndedF,
  this.onDragStartedF,
  this.skipOnScreenCheck \= false,
  this.resizeableH \= false,
  this.resizeableV \= false,
  this.onResizeF,
  this.draggableColor,
  this.showGotitButton \= false,
  this.gotitAxis,
  this.onGotitPressedF,
  this.showcpi \= false,
  this.onlyOnce,		// only show this callout once  
  this.containsTextField \= false,
  this.alwaysReCalcSize \= false,
  this.ignoreCalloutResult \= false,
  this.finalSeparation,	// on initial display, animates to this separation  
  this.onDismissedF,		// callback when callout dismissed  
  this.onTickedF,
  this.onHiddenF,
  this.onAcceptedF
})
```
## API documentation
To learn more about the API, visit [https://biancashouse.com/flutter_callouts_doc](https://biancashouse.com/flutter_callouts_doc)

## Callout Designer
While this package makes it easy to configure your callouts in dart, we also publish another package, **flutter\_content**, (built on this package) that enables users to create and configure callouts **visually**,
and have their configuration and content stored as **json** in their firestore database.

To learn more, please visit the [**flutter_content** on pub.dev](https://pub.dev/packages/flutter_content)
