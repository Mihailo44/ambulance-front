import 'dart:developer';

import 'package:ambulance_app/generic_widgets/buttons/button.dart';
import 'package:ambulance_app/mock_data/questions_mock.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/model/response.dart' as my;
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<Question> _questions = [];
  final List<my.Response> _responses = [];
  int questionIndex = 0;

  List<String> getShufled() {
    final listCopy = List.of(_questions[questionIndex].availableAnswers);
    listCopy.shuffle();
    return listCopy;
  }

  @override
  void initState() {
    super.initState();
    _questions.addAll(QuestionsMock.questions);
  }

  void _answerQuestion(String answer) {
    setState(() {
      if (questionIndex < _questions.length - 1) {
        questionIndex++;
        var response = my.Response(
            question: _questions[questionIndex].body, response: answer);
        for (int i = 0; i < _responses.length; i++) {
          if (_responses[i].question == _questions[questionIndex].body) {
            if (_responses[i].response != answer) {
              _responses[i].response = answer;
            }
          } else {
            _responses.add(response);
            break;
          }
        }
      } else {
        //TODO sva pitanja odgovorena salji zahtev i obrisi listu odgovora

        for (int i = 0; i < _responses.length; i++) {
          print(_responses[i].response);
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = _questions[questionIndex];

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentQuestion.body,
              textAlign: TextAlign.center,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: const Color.fromARGB(255, 210, 227, 252),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.25, 60),
                  ),
                  onPressed: () {
                    setState(() {
                      if (questionIndex > 0) {
                        questionIndex--;
                      } else {
                        showSnackBar(context, "This is the first question");
                      }
                    });
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      color: Color.fromARGB(255, 23, 78, 166),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.35, 60),
                  ),
                  onPressed: () {
                    setState(() {
                      if (questionIndex < _questions.length - 1) {
                        questionIndex++;
                      } else {
                        
                      }
                    });
                  },
                  child: const Text(
                    "I don't know",
                    style: TextStyle(
                      color: Color.fromARGB(255, 23, 78, 166),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
