import 'package:flutter/material.dart';
import 'result_screen.dart';

class Question {
  final String text;
  final bool answer;
  final String explanation;

  Question(this.text, this.answer, this.explanation);
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'クイズページ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(selectedQuiz: 1),
    );
  }
}

class QuizPage extends StatefulWidget {
  final int selectedQuiz;
  QuizPage({required this.selectedQuiz});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<bool?> userAnswers;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    userAnswers = List.filled(widget.selectedQuiz, null);
    questions = [
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
  }

  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  void checkAnswer(bool userAnswer) {
    String explanation = questions[currentQuestionIndex].explanation;
    bool isCorrect = userAnswer == questions[currentQuestionIndex].answer;

    userAnswers[currentQuestionIndex] = isCorrect;

    String userSymbol = userAnswer ? '〇' : '☓';
    String correctAnswerSymbol =
    questions[currentQuestionIndex].answer ? '〇' : '☓';

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
                      _showResultDialog();
                    }
                  });
                },
                child: Text(currentQuestionIndex < questions.length - 1
                    ? '次へ'
                    : '結果を見る'),
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

  void _retryQuiz() {
    // 同じクイズを再度表示
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      userAnswers = List.filled(questions.length, null);
    });
    Navigator.of(context).pop(); // 結果画面を閉じる
  }

  void _goToHome() {
    // ホームに戻る
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _showResultDialog() {
    print('Show result dialog called');
    // 各回答が正解かどうかを示すブール値のリストを作成
    List<bool?> isCorrectList = List.generate(
      questions.length,
          (index) => userAnswers[index] == questions[index].answer,
    );

    // ResultScreen に遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: questions,
          userAnswers: userAnswers,
          isCorrectList: isCorrectList,
          retryQuiz: _retryQuiz,
          goToHome: _goToHome,
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
