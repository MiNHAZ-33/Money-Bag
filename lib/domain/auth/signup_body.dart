// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignUpBody extends Equatable {
  final String name;
  final String email;
  final String password;
  const SignUpBody({
    required this.name,
    required this.email,
    required this.password,
  });

  SignUpBody copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return SignUpBody(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory SignUpBody.fromMap(Map<String, dynamic> map) {
    return SignUpBody(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpBody.fromJson(String source) => SignUpBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, password];
}
