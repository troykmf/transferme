class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'profilePicture': profilePicture,
    'phoneNumber': phoneNumber,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    profilePicture: json['profilePicture'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
  );

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? profilePicture,
    String? phoneNumber,
  }) => UserModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    profilePicture: profilePicture ?? this.profilePicture,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );
}
