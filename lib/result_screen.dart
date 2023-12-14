import 'package:flutter/material.dart';
import 'quiz_page.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<bool?> userAnswers;
  final List<bool?> isCorrectList;  // この行を変更
  final void Function() retryQuiz;
  final void Function() goToHome;

  ResultScreen({
    required this.questions,
    required this.userAnswers,
    required this.isCorrectList,
    required this.retryQuiz,
    required this.goToHome,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('結果発表'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '結果',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Question question = questions[index];
                  bool isCorrect = question.answer == userAnswers[index];

                  return ListTile(
                    title: Text(
                      '問${index + 1}: ${question.text}',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                    subtitle: isCorrect
                        ? Text(
                      '正解',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )
                        : Text(
                      '不正解',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('解説'),
                            content: Text(question.explanation),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('閉じる'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: retryQuiz,
                  child: Text('もう一回'),
                ),
                ElevatedButton(
                  onPressed: goToHome,
                  child: Text('ホームに戻る'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
