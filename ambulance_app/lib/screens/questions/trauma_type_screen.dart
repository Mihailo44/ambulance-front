import 'package:ambulance_app/generic_widgets/trauma_type_card.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/screens/questions/questions_screen.dart';
import 'package:flutter/material.dart';

class TraumaTypeScreen extends StatelessWidget {
  TraumaTypeScreen({super.key});

  final List<String> traumaTypes = TraumaType.values.map((e) {
    return e.name.replaceAll(RegExp("_"), " ").toUpperCase();
  }).toList();

  @override
  Widget build(BuildContext context) {

     void _openTraumaQuestionsOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const Border(top: BorderSide.none),
      context: context, 
      builder: (ctx) => const QuestionsScreen(),);
    }

    return Column(children: [
      const SizedBox(height:  20.0,),
      const Text(
        "Please select the trauma type",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 2, 41, 108)
        ),
      ),
      const SizedBox(height:  20.0,),
      Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 1.6 / 1,
          ),
          itemCount: traumaTypes.length,
          itemBuilder: (context, index) {
            return TraumaTypeCard(label: traumaTypes[index],onTap: _openTraumaQuestionsOverlay);
          },
        ),
      ),
    ]);
  }
}