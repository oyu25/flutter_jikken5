import 'package:flutter/material.dart';
import 'result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ログイン画面',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      '「あがいん」は、「お食べなさい」という意味である。',
      true,
      '「お食べなさい」という意味である。',
    ),
    Question(
      '「あがらいん」は、「ちょっと家に入ってきなさい」という意味である。',
      true,
      '「ちょっと家に入ってきなさい」という意味である。',
    ),
    Question(
      '「あぐど」は、「トンボ」という意味である。',
      false,
      '「かかと」という意味である。',
    ),
    // Add more questions as needed
  ];

  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int quizCount = 0;

  void checkAnswer(bool userAnswer) {
    String explanation = questions[currentQuestionIndex].explanation;
    bool isCorrect = userAnswer == questions[currentQuestionIndex].answer;

    String userSymbol = userAnswer ? '〇' : '☓';
    String correctAnswerSymbol = questions[currentQuestionIndex].answer ? '〇' : '☓';

    // 新しい選択肢情報
    bool? userChoice = userAnswer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('あなたの回答: $userSymbol'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isCorrect
                  ? Text('正解！')
                  : Text('不正解... 正解は「$correctAnswerSymbol」です。'),
              Text(explanation),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Move to the next question or show the result
                  setState(() {
                    if (currentQuestionIndex < questions.length - 1) {
                      currentQuestionIndex++;
                    } else {
                      // Quiz is finished, show the score
                      showResultDialog(userChoice);
                    }
                  });
                },
                child: Text(currentQuestionIndex < questions.length - 1 ? '次へ' : '結果を見る'),
              ),
            ],
          ),
        );
      },
    );

    if (isCorrect) {
      setState(() {
        correctAnswers++;
      });
    }
  }

  void showResultDialog(bool? userChoice) {
    // ResultScreen に遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: questions,
          userAnswers: List.generate(questions.length, (index) {
            return index < correctAnswers;
          }),
          userChoices: List.generate(questions.length, (index) {
            return index == currentQuestionIndex ? userChoice : null;
          }),
          retryQuiz: () {
            // もう一回ボタンが押されたときの処理
            Navigator.of(context).pop(); // 結果画面を閉じる
            // クイズをリセット
            setState(() {
              currentQuestionIndex = 0;
              correctAnswers = 0;
              quizCount = 0;
            });
          },
          goToHome: () {
            // ホームに戻るボタンが押されたときの処理
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('方言〇☓ゲーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '第${currentQuestionIndex + 1}問',
            ),
            Text(
              '${questions[currentQuestionIndex].text}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text('〇'),
                ),
                ElevatedButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text('☓'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final bool answer;
  final String explanation;

  Question(this.text, this.answer, this.explanation);
}
