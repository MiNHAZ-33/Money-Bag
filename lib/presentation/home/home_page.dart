import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/auth_state.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/presentation/auth/login_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider.select((value) => value.profile));
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

    return Scaffold(
        appBar: AppBar(
          title: const Text('Money Bag'),
        ),
        body: Center(
          child: Text(state.name),
        ));
  }
}
