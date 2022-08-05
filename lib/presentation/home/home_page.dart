import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/auth_state.dart';
import 'package:moneybook/application/auth/transaction/transaction_provider.dart';
import 'package:moneybook/application/auth/transaction/transaction_state.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/presentation/auth/login_page.dart';
import 'package:moneybook/presentation/home/widgets/top_part.dart';
import 'package:moneybook/presentation/home/widgets/transaction_dialogue.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final profile = ref.watch(authProvider.select((value) => value.profile));
    ref.listen<AuthState>(authProvider, ((previous, next) {
      if (previous?.profile != next.profile &&
          next.profile == UserProfile.isEmpty()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    }));

    ref.listen<TransactionState>(transactionProvider, (previous, next) {
      if (previous != next) {
        if (next.failure != CleanFailure.none()) {
          CleanFailureDialogue.show(context, failure: next.failure);
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Money Bag'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
              icon: const Icon(Icons.logout_sharp))
        ],
      ),
      body: ListView(
        children: [
          TopPart(profile: profile),
        ],
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('Log Out'),
        onPressed: () {
          //
          showDialog(
            context: context,
            builder: (context) {
              return const TransactionDialog();
            },
          );
        },
      ),
    );
  }
}
