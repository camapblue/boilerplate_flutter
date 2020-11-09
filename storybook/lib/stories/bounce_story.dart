// import 'package:common/widget.dart';
// import 'package:flutter/material.dart';
// import '../storybook.dart';

// class BounceStory extends Story {
//   @override
//   List<WidgetMap> storyContent(BuildContext context) {
//     return [
//       WidgetMap(
//         title: 'Common | Bounce',
//         widget: Scaffold(
//           backgroundColor: Colors.grey,
//           body: Column(
//             children: <Widget>[
//               Expanded(
//                 child: Container(),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 96,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Bounce(
//                     onPressed: () {
//                       print('Card Touched');
//                     },
//                     child: const Card(
//                       child: Center(child: Text('Card here'),),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//             ],
//           ),
//         ),
//       )
//     ];
//   }
// }
