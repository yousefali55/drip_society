import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  const CustomerModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.postalCode,
  });

  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String city;
  final String postalCode;

  String get fullName => '$firstName $lastName'.trim();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'postalCode': postalCode,
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id']?.toString(),
      firstName: (json['firstName'] ?? json['first_name'] ?? '').toString(),
      lastName: (json['lastName'] ?? json['last_name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? json['phone_number'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      postalCode: (json['postalCode'] ?? json['postal_code'] ?? '').toString(),
    );
  }

  CustomerModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? postalCode,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, email, phoneNumber, city, postalCode];
}
