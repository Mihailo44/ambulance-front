class Response {
  final int id;
  final String question;
  String? response;

  Response({
    required this.id,
    required this.question,
    this.response
  });

}