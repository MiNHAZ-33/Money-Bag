import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/auth_state.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/presentation/auth/login_page.dart';
import 'package:moneybook/presentation/home/home_page.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect((() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(authProvider.notifier).checkAuth();
      });
      return null;
    }), []);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure != CleanFailure.none() ||
            next.profile == UserProfile.isEmpty()) {
          if (next.failure != CleanFailure.none()) {
            Logger.e(next.failure);
            CleanFailureDialogue.show(context, failure: next.failure);
          }
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
        else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
      } 
    });
    return Scaffold(
      body: Column(
        children: const [
          Text(
            'Moneybag',
            style: TextStyle(fontSize: 40),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
