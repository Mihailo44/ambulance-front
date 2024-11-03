import 'package:ambulance_app/model/question.dart';

class Quiz {
  final TraumaType traumaType;
  final List<Question> questions;

  const Quiz({required this.traumaType, required this.questions});
}
