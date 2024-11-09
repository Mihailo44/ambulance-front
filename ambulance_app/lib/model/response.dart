class Response {
  final int id;
  final String question;
  String? response; //TODO pitanje moze imati vise odgovora, npr sta je neko slomio

  Response({
    required this.id,
    required this.question,
    this.response
  });

}