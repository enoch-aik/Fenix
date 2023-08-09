class UserModel {
  UserModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.city,
    required this.address,
    required this.country,
    required this.username,
    required this.pictureUrl,
    required this.location
  });

  String? id;
  String? userId;
  String? email;
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? city;
  String? address;
  String? country;
  String? username;
  String? pictureUrl;
  Map? location;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
    userId: json["userId"],
        email: json["email"] ?? '',
        mobileNumber: json["phoneNumber"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        gender: json["gender"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
        country: json["country"] ?? '',
        username: json["username"] ?? '',
    pictureUrl: json["pictureUrl"] ?? '',
    location: json["location"] ?? '',
      );
}
