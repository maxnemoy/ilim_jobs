import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';
import 'package:routemaster/routemaster.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _username = TextEditingController();
    final TextEditingController _password = TextEditingController();
    return BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Routemaster.of(context).push("/profile");
          }
          if (state is NotAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Авторизация завершилась с ошибкой.",
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) => Column(
            children: [
              TextField(
                controller: _username,
              ),
              TextField(
                controller: _password,
              ),
              if (state is AuthenticationLoading)
                const LinearProgressIndicator(),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationCubit>().login(UserData(
                        username: _username.text, password: _password.text));
                  },
                  child: const Text("Войти"))
            ],
          ),
        ));
  }
}
