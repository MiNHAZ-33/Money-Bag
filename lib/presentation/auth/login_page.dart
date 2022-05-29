import 'package:clean_api/clean_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/auth_state.dart';
import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/domain/auth/login_body.dart';
import 'package:moneybook/presentation/auth/signup_page.dart';
import 'package:moneybook/presentation/home/home_page.dart';
import 'package:moneybook/presentation/util/validation_rules.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final formKey = useMemoized((() => GlobalKey<FormState>()));
    final state = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure != CleanFailure.none() ||
            next.profile == UserProfile.isEmpty()) {
          if (next.failure != CleanFailure.none()) {
            CleanFailureDialogue.show(context, failure: next.failure);
          }
          
        }
        else {
       Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
      }
      } 
    });

    return Scaffold(
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 40, color: Colors.deepPurple),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: ValidationRules.email,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !showPassword.value,
                    validator: ValidationRules.password,
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: () {
                          showPassword.value = !showPassword.value;
                        },
                        child: showPassword.value
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                      label: const Text('Password'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: (() {
                      if (formKey.currentState?.validate() ?? false) {
                        ref.read(authProvider.notifier).login(LogInBody(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()));
                      }
                    }),
                    child: const Text('Log In'),
                  ),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    }),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
    );
  }
}
