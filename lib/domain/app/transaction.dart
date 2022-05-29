// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final double amount;
  final DateTime time;
  final String source;
  final String transactionType;
  final String note;
  const Transaction({
    required this.amount,
    required this.time,
    required this.source,
    required this.transactionType,
    required this.note,
  });

  Transaction copyWith({
    double? amount,
    DateTime? time,
    String? source,
    String? transactionType,
    String? note,
  }) {
    return Transaction(
      amount: amount ?? this.amount,
      time: time ?? this.time,
      source: source ?? this.source,
      transactionType: transactionType ?? this.transactionType,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
      'source': source,
      'transactionType': transactionType,
      'note': note,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      amount: map['amount'] as double,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      source: map['source'] as String,
      transactionType: map['transactionType'] as String,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      amount,
      time,
      source,
      transactionType,
      note,
    ];
  }
}
