// import 'package:common/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:boilerplate_flutter/widgets/widgets.dart';
// import 'package:boilerplate_flutter/theme/theme.dart';
// import 'package:boilerplate_flutter/constants/constants.dart';
// import '../storybook.dart';

// class BounceButtonStory extends Story {
//   @override
//   List<WidgetMap> storyContent(BuildContext context) {
//     return [
//       WidgetMap(
//         title: 'Common | Bounce Button',
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
//                   child: BounceButton(
//                     title: 'Touch Here',
//                     borderRadius: BorderRadius.circular(16),
//                     onPressed: () {
//                       print('Touched');
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 96,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: BounceButton(
//                     title: 'Touch Here',
//                     borderRadius: BorderRadius.circular(16),
//                     onPressed: () {
//                       print('Touched');
//                     },
//                     isLoading: true,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 96,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: BounceButton(
//                     title: 'Touch Here',
//                     color: redColor,
//                     borderRadius: BorderRadius.circular(16),
//                     onPressed: () {
//                       print('Touched');
//                     },
//                     isLoading: true,
//                     loadingText: 'Processing',
//                     loadingTextStyle: Theme.of(context).loadingTextStyle,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 96,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: BounceButton(
//                     icon: AppIcon(
//                       icon: AppIcons.bell,
//                       width: 20,
//                       height: 20,
//                       color: Colors.white,
//                     ),
//                     title: 'Align Left',
//                     alignment: Alignment.centerLeft,
//                     borderRadius: BorderRadius.circular(16),
//                     onPressed: () {
//                       print('Touched');
//                     },
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
