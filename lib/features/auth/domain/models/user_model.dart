class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;

  UserModel({required this.id, required this.fullName, required this.phoneNumber, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
    );
  }
}
