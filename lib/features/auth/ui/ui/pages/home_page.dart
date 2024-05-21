import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import 'login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _logOut(context);
              },
            ),
          ),
          body: ListView.builder(
            itemCount: 25,
            itemBuilder: (context, index) {
              return Card(
                child: Center(child: Text(index.toString())),
              );
            },
          )),
    );
  }

  void _logOut(BuildContext context) {
    context.read<AuthCubit>().signOut();
  }
}
