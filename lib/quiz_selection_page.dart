// import 'package:flutter/material.dart';
// import 'quiz_page.dart';
//
// class QuizSelectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('クイズ選択'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//         ),
//         itemCount: 40,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => QuizPage(selectedQuiz: index + 1)),
//               );
//             },
//             child: Card(
//               child: Center(
//                 child: Text('クイズ ${index + 1}'),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

