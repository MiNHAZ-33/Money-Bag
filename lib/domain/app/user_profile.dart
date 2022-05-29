// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:moneybook/domain/app/source.dart';

class UserProfile extends Equatable {
  final String name;
  final String id;
  final String email;
  final List<Source> sources;
  const UserProfile({
    required this.name,
    required this.id,
    required this.email,
    required this.sources,
  });

  UserProfile copyWith({
    String? name,
    String? id,
    String? email,
    List<Source>? sources,
  }) {
    return UserProfile(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      sources: sources ?? this.sources,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'sources': sources.map((x) => x.toMap()).toList(),
    };
  }

  factory UserProfile.isEmpty() =>
      const UserProfile(name: '', id: '', email: '', sources: []);

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      sources: List<Source>.from(
        (map['sources'] as List<dynamic>).map<Source>(
          (x) => Source.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, id, email, sources];
}
