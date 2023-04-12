class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,

  });

  String ?id;
  String ?email;
  String ?mobileNumber;
  String ?firstName;
  String ?lastName;
  String ?gender;


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"] ?? '',
    mobileNumber: json["mobileNumber"] ?? '',
    firstName: json["firstName"]??'',
    lastName: json["lastName"]??'',
    gender: json["gender"],
  );
}
