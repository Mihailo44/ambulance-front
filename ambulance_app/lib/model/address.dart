class Address {
  int? id;
  String country;
  String city;
  String street;
  String number;
  String? floor;
  String? apartmentNumber;
  // lamela zgrade

  Address(
      {this.id,
      this.country = "Srbija",
      required this.city,
      required this.street,
      required this.number,
      this.floor,
      this.apartmentNumber});

  Address copyWith(
    String city,
    String street,
    String number, {
    String country = "Srbija",
    String? floor,
    String? appartmentNumber,
    //String? buildingBlock,
  }) {
    return Address(
      city: city, 
      street: street, 
      number: number,
      country: country,
      floor: floor,
      apartmentNumber: appartmentNumber,
      );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      country: json['country'],
      city: json['city'],
      street: json['street'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'street': street,
      'number': number,
    };
  }
}
