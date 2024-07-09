import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_files/routes/custome_router.dart';
import '../../providers/login_notifier/login_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(LoginNotifier.provider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: loginNotifier.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: loginNotifier.usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: loginNotifier.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (loginNotifier.formKey.currentState!.validate()) {
                    await loginNotifier.login();
                  }
                },
                child: const Text('Login'),
              ),
              const LoginListner(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginListner extends ConsumerWidget {
  const LoginListner({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final loginState = ref.watch(LoginNotifier.provider);

    return loginState.when(
      data: (loginResponse) {
        if (loginResponse != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(AppRoute.home.name);
          });
        }
        return loginResponse != null
            ? Text('Welcome, ${loginResponse.username}')
            : Container();
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: ${error.toString()}'),
    );
  }
}
