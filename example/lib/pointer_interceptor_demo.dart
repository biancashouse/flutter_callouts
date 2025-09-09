// import 'package:pointer_interceptor/pointer_interceptor.dart';
// import 'package:flutter/material.dart';
//
// import 'native_widget.dart';
//
// const double _videoWidth = 640;
// const double _videoHeight = 480;
//
//
// /// First page
// class PointerInterceptorDemo extends StatefulWidget {
//   /// Creates first page.
//   const PointerInterceptorDemo({super.key});
//
//   @override
//   State<PointerInterceptorDemo> createState() => _PointerInterceptorDemoState();
// }
//
// class _PointerInterceptorDemoState extends State<PointerInterceptorDemo> {
//   String _lastClick = 'none';
//
//   void _clickedOn(String key) {
//     setState(() {
//       _lastClick = key;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('PointerInterceptor demo'),
//           actions: <Widget>[
//             PointerInterceptor(
//               debug: true,
//               child: IconButton(
//                 icon: const Icon(Icons.add_alert),
//                 tooltip: 'AppBar Icon',
//                 onPressed: () {
//                   _clickedOn('appbar-icon');
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Last click on: $_lastClick',
//                 key: const Key('last-clicked'),
//               ),
//               Container(
//                 color: Colors.black,
//                 width: _videoWidth,
//                 height: _videoHeight,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: <Widget>[
//                     NativeWidget(
//                       key: const ValueKey<String>('background-widget'),
//                       onClick: () {
//                         _clickedOn('native-element');
//                       },
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         ElevatedButton(
//                           key: const Key('transparent-button'),
//                           child: const Text('Never calls onPressed'),
//                           onPressed: () {
//                             _clickedOn('transparent-button');
//                           },
//                         ),
//                         PointerInterceptor(
//                           intercepting: false,
//                           child: ElevatedButton(
//                             key: const Key('wrapped-transparent-button'),
//                             child:
//                             const Text('Never calls onPressed transparent'),
//                             onPressed: () {
//                               _clickedOn('wrapped-transparent-button');
//                             },
//                           ),
//                         ),
//                         PointerInterceptor(
//                           child: SizedBox(width: double.infinity,
//                             child: ElevatedButton(
//                               key: const Key('clickable-button'),
//                               child: const Text('Works As Expected'),
//                               onPressed: () {
//                                 _clickedOn('clickable-button');
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             PointerInterceptor(
//               debug: true,
//               child: FloatingActionButton(
//                 child: const Icon(Icons.navigation),
//                 onPressed: () {
//                   _clickedOn('fab-1');
//                 },
//               ),
//             ),
//           ],
//         ),
//         drawer: Drawer(
//           child: PointerInterceptor(
//             intercepting: false,
//             debug: true, // Enable this to "see" the interceptor covering the column.
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ListTile(
//                   title: const Text('Item 1'),
//                   onTap: () {
//                     _clickedOn('drawer-item-1');
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('Item 2'),
//                   onTap: () {
//                     _clickedOn('drawer-item-2');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }