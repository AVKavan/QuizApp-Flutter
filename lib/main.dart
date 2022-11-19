import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

QuizBrain quizBrain = new QuizBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Quizzler',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Quizpage(),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Widget> ScoreTrack = [];
  int score = 0;
  void checkAnswer(bool CrctAns, bool answerGiven) {
    if (CrctAns == answerGiven) {
      ScoreTrack.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
      score++;
    } else {
      ScoreTrack.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }

    if (quizBrain.finished() == true) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "QUIZ IS COMPLETED",
        desc: "Your Score is $score.",
        buttons: [
          DialogButton(
              child: Text(
                "Back to Quiz",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                Color.fromRGBO(0, 179, 134, 1.0);
                setState(() {
                  quizBrain.reset();
                  ScoreTrack.clear();
                });
              }),
          DialogButton(
              child: Text(
                "Exit App",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]);
                SystemNavigator.pop();
              })
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(quizBrain.getQuestionText(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  checkAnswer(quizBrain.getAnswer(), true);
                  quizBrain.nextQuestion();
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: Text('True',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  checkAnswer(quizBrain.getAnswer(), false);
                  quizBrain.nextQuestion();
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(
          children: ScoreTrack,
        )
      ],
    );
  }
}
