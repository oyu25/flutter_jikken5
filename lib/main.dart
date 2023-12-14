import 'package:flutter/material.dart';
import 'quiz_page.dart'; // quiz_page.dart ファイルをインポート

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('クイズ&単語帳'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                  // QuizPage に遷移
                );
              },
              child: Text('クイズへ'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // ここに辞書ページへの遷移を追加する
              },
              child: Text('辞書へ'),
            ),
          ],
        ),
      ),
    );
  }
}
