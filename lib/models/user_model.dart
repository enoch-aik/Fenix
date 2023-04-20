class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.city,
    required this.address,
    required this.country,
    required this.username,
  });

  String? id;
  String? email;
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? city;
  String? address;
  String? country;
  String? username;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"] ?? '',
        mobileNumber: json["phoneNumber"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        gender: json["gender"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
        country: json["country"] ?? '',
        username: json["username"] ?? '',
      );
}
