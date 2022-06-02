import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:fpdart/src/unit.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:clean_api/src/api_failure.dart';
import 'package:moneybook/domain/app/i_transaction_repo.dart';
import 'package:moneybook/domain/app/transaction.dart';

class TransactionRepo extends ITransactionRepo {
  final db = FirebaseFirestore.instance;
  @override
  TaskEither<CleanFailure, Unit> submitTransaction(
          {required String uid, required Transaction transaction}) =>
      TaskEither.tryCatch(
        () async {
          await db
              .collection('User')
              .doc(uid)
              .collection('transaction')
              .add(transaction.toMap());

          return unit;
        },
        (error, stackTrace) => CleanFailure(
          tag: 'Submit Transaction',
          error: error.toString(),
        ),
      );
}
