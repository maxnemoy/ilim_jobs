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
          builder: (context, state) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_sharp, size: 100, color: Theme.of(context).colorScheme.onBackground,),
                    Text("Войдите, чтобы продолжить", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),),
                    const SizedBox(height: 40,),
                    TextField(
                      controller: _username,
                      decoration: const InputDecoration(label: Text("Имя пользователя"), prefixIcon: Icon(Icons.person)),
                    ),
                    TextField(
                      obscureText: true,
                      controller: _password,
                      decoration: const InputDecoration(label: Text("Пароль"), prefixIcon: Icon(Icons.lock)),
                    ),
                    if (state is AuthenticationLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 40,),
                    ElevatedButton(
                        onPressed: () {
                          context.read<AuthenticationCubit>().login(UserData(
                              username: _username.text, password: _password.text));
                        },
                        child: const Text("Войти"))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
