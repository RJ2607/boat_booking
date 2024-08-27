class PassengerModel {
  final String? fullName;
  final String? age;
  final String? gender;

  PassengerModel({
    this.fullName,
    this.age,
    this.gender,
  });

  PassengerModel copyWith({
    String? fullName,
    String? age,
    String? gender,
  }) {
    return PassengerModel(
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
    };
  }

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      fullName: json['fullName'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}
