import 'package:ambulance_app/generic_widgets/trauma_type_card.dart';
import 'package:ambulance_app/model/question.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/questions/questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TraumaTypeScreen extends ConsumerWidget {
  TraumaTypeScreen({super.key});

  final List<String> traumaTypes = TraumaType.values.map((e) {
    return e.name.replaceAll(RegExp("_"), " ").toUpperCase();
  }).toList();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
              Navigator.pop(context);
            }),
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
      ),
      body: Column(children: [
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "Please select the trauma cause",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 1.6 / 1,
            ),
            itemCount: traumaTypes.length,
            itemBuilder: (context, index) {
              return TraumaTypeCard(
                  label: traumaTypes[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          final traumaType =
                              parseTraumaType(traumaTypes[index]);
                          return QuestionsScreen(traumaCause: traumaType);
                        },
                      ),
                    );
                  });
            },
          ),
        ),
      ]),
    );
  }
}
