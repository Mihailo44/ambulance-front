import 'dart:developer';

import 'package:ambulance_app/generic_widgets/buttons/button.dart';
import 'package:ambulance_app/generic_widgets/buttons/questions_button.dart';
import 'package:ambulance_app/mock_data/questions_mock.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/model/quiz.dart';
import 'package:ambulance_app/model/response.dart' as my;
import 'package:ambulance_app/screens/questions/patients_list.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.traumaCause, super.key});

  final TraumaType traumaCause;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<Question> _questions = [];
  final List<my.Response> _responses = [];
  final _customAnswerController = TextEditingController();
  int questionIndex = 0;

  List<String> getShufled() {
    final listCopy = List.of(_questions[questionIndex].availableAnswers);
    listCopy.shuffle();
    return listCopy;
  }

  @override
  void initState() {
    super.initState();
    Quiz q =
        QuizMock.quizes.firstWhere((e) => e.traumaType == widget.traumaCause);
    _questions.addAll(q.questions);
  }

  @override
  void dispose() {
    //TODO obrisi listu odgovora
    super.dispose();
    _customAnswerController.dispose();
  }

  void _previousQuestion() {
    if (questionIndex > 0) {
      setState(() {
        questionIndex--;
      });
    } else {
      showSnackBar(context, "This is the first question");
    }
  }

  void _nextQuestion() {
    if (questionIndex < _questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const VictimList()));
    }
  }

  void _answerQuestion(String answer) {
  
    var response = my.Response(
        id: questionIndex,
        question: _questions[questionIndex].body,
        response: answer);

    if (_responses.length > questionIndex) {
      if (_responses[questionIndex].response != answer) {
        _responses[questionIndex].response = answer;
      }
    } else {
        _responses.add(response);
    }

    if (questionIndex != _questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    }else{
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const VictimList()));
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = _questions[questionIndex];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }),
        title: Text("Question ${questionIndex + 1}/${_questions.length}"),
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 56 - 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: AutoSizeText(
                  currentQuestion.body,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 15.0),
              ...currentQuestion.availableAnswers.map((answer) {
                return AnswerButton(
                  answerText: answer,
                  onTap: () {
                    _answerQuestion(answer);
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 15, 60, 20),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  autocorrect: true,
                  controller: _customAnswerController,
                  decoration: InputDecoration(
                    hintText: "Custom answer",
                    contentPadding: const EdgeInsets.all(2),
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: QuestionsButton(
                      label: "Back",
                      fun: _previousQuestion,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: QuestionsButton(
                        label: "I don't know",
                        fun: _nextQuestion,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
