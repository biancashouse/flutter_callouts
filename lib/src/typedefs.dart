// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_callouts/src/feature_discovery/discovery_controller.dart';
import 'package:flutter_callouts/src/feature_discovery/featured_widget.dart';

typedef CalloutId = String;
// typedef TextStyleName = String;
// typedef SnippetName = String;
// typedef BucketName = String;
// typedef BranchName = String;
// typedef PanelName = String;
// typedef SnippetPlaceName = String; // panel or placeholder name
// typedef RouteName = String;
typedef TargetId = int;
// typedef VersionId = String;
// typedef EncodedJson = String;
// typedef EncodedSnippetJson = String;
// typedef JsonMap = Map<String, dynamic>;
// typedef SizeFunc = Size Function();
// typedef PosFunc = Offset Function();
//
// typedef DoubleFunc = double Function();

// typedef OverlayContentFunc = Widget Function({GlobalKey callerGK});
typedef TargetKeyFunc = GlobalKey? Function();

typedef KeystrokeHandler = bool Function(KeyEvent event);

// typedef CalloutConfigChangedF = void Function(Alignment newTA, ArrowTypeEnum newAT);

// typedef HandlerName = String;

// typedef PropertyName = String;

// typedef GksByFeature = Map<Feature, GlobalKey>;
// typedef GksByTargetId = Map<TargetId, GlobalKey>;
// typedef FeatureList = List<Feature>;

typedef TxtChangedF = void Function(String);

typedef FeaturedWidgetHelpContentBuilder = Widget Function(
    BuildContext context, FeaturedWidget? parent);

typedef FeaturedWidgetActionF = void Function(
    BuildContext, DiscoveryController);

typedef TextStyleF = TextStyle Function();
typedef TextAlignF = TextAlign Function();

// typedef JSON = Map<String, dynamic>;
typedef SnippetJson = String;

typedef SetStateF = void Function(VoidCallback f);

// typedef ColorValue = int;

typedef RectFunc = Rect? Function();
typedef BoolFunc = bool Function();

// typedef PageWidget = Widget Function(final String pagePath);
// typedef PassBlocF = void Function(CAPIBloc);
// typedef PassGlobalKeyF = void Function(GlobalKey);

// typedef TextAlignCallback = void Function(NodeTextAlign value);
// typedef AnimateArrowFunc = bool Function();
// typedef ArrowTypeFunc = ArrowType Function();
// typedef TextStyleFunc = TextStyle Function();
// typedef TextAlignFunc = TextAlign Function();

// typedef Adder<Node> = void Function({Node? parentNode, required Node selectedNode, required Node newNode});