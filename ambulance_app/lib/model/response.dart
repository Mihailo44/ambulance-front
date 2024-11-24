class Response {
  final int id;
  final String question;
<<<<<<< HEAD
  String? response;
=======
  String? response; //TODO pitanje moze imati vise odgovora, npr sta je neko slomio
>>>>>>> main

  Response({
    required this.id,
    required this.question,
    this.response
  });

}