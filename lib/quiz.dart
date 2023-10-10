import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_screen.dart';
import 'package:quiz/results_screen.dart';
import 'package:quiz/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Widget? activeScreen;
  List<String> selectedAnswers = [];

  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer (String answer) {
    selectedAnswers.add(answer);
     
     if (selectedAnswers.length == questions.length) {
      setState(() {
        // selectedAnswers = [];
        activeScreen = 'results-screen';
      });
     }
  }

void restartQuiz() {
  setState(() {
    selectedAnswers = [];
    activeScreen = 'questions-screen';
  });
}
// ignore: non_constant_identifier_names
void Exit(){
  setState(() {
    selectedAnswers = [];
    activeScreen = 'start-screen';
  });
}


  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectedAnswer : chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen'){
      screenWidget = ResultScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
         OnExit: Exit ,
      );
    }
    // final screenWidget = activeScreen == 'start-screen'
    // ? StartScreen(switchScreen)
    // :const QuestionsScreen();
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 234, 250, 154),
                  Color.fromARGB(233, 110, 178, 76),
                  Color.fromARGB(243, 141, 148, 237),
                  Color.fromARGB(122, 345, 672, 234),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: screenWidget),
      ),
    );
  }
}
