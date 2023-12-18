import 'package:flutter/material.dart';
import 'quiz_page.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<bool> userAnswers;
  final List<bool?> userChoices;
  final VoidCallback retryQuiz;
  final VoidCallback goToHome;

  ResultScreen({
    required this.questions,
    required this.userAnswers,
    required this.userChoices,
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
                  bool isUserAnswerCorrect = userChoices[index] != null && userChoices[index]! == question.answer;

                  return Card(
                    color: isUserAnswerCorrect ? Colors.green[100] : (isCorrect ? Colors.red[100] : null),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '問${index + 1}: ${question.text}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '正解: ${question.answer ? '〇' : '☓'}',
                            style: TextStyle(
                              color: isCorrect || isUserAnswerCorrect ? Colors.green : null,
                            ),
                          ),
                          if (userChoices[index] != null)
                            Text(
                              'あなたの回答: ${userChoices[index]! ? '〇' : '☓'}',
                              style: TextStyle(
                                color: isUserAnswerCorrect ? Colors.green : Colors.red,
                              ),
                            ),
                          SizedBox(height: 8.0),
                          Text(
                            '解説: ${question.explanation}',
                          ),
                        ],
                      ),
                    ),
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
