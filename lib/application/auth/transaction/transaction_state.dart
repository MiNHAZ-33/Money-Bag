// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:moneybook/domain/app/transaction.dart';

class TransactionState extends Equatable {
  final CleanFailure failure;
  final List<Transaction> transactions;
  const TransactionState({
    required this.failure,
    required this.transactions,
  });

  TransactionState copyWith({
    CleanFailure? failure,
    List<Transaction>? transactions,
  }) {
    return TransactionState(
      failure: failure ?? this.failure,
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionState.init() =>
      TransactionState(failure: CleanFailure.none(), transactions: const []);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [failure, transactions];
}
