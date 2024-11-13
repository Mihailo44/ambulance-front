class Address {
  int? id;
  String country;
  String city;
  String street;
  String number;

  Address({
    this.id,
    required this.country,
    required this.city,
    required this.street,
    required this.number,
  });

  factory Address.fromJson(Map<String,dynamic> json){
    return Address(
      id: json['id'],
      country: json['country'],
      city: json['city'],
      street: json['street'],
      number: json['number'],
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'country':country,
      'city':city,
      'street':street,
      'number':number,
    };
  }

}