import 'package:clean_api/clean_api.dart';
import 'package:moneybook/domain/app/transaction.dart';

abstract class ITransactionRepo {
  TaskEither<CleanFailure, Unit> submitTransaction(
      {required String uid, required Transaction transaction});
}
