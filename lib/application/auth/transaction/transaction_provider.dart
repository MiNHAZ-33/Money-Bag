import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/transaction/transaction_state.dart';
import 'package:moneybook/domain/app/i_transaction_repo.dart';
import 'package:moneybook/domain/app/transaction.dart';
import 'package:moneybook/infrastructure/transaction_repo.dart';

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>(
  (ref) {
    final uid = ref.watch(authProvider.select((value) => value.profile.id));
    return TransactionNotifier(uid, TransactionRepo());
  },
);

class TransactionNotifier extends StateNotifier<TransactionState> {
  final String uid;
  final ITransactionRepo transactionRepo;
  TransactionNotifier(this.uid, this.transactionRepo)
      : super(TransactionState.init());

  submit(Transaction transaction) async {
    final data = await transactionRepo
        .submitTransaction(uid: uid, transaction: transaction)
        .run();

    state = state.copyWith(failure: data.fold((l) => l, (r) => CleanFailure.none()));
  }
}
