import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:routemaster/routemaster.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is NotAuthenticated) {
          Routemaster.of(context).push("/profile");
        }
      },
      child: Column(children: [
        Text("Username: ${getIt<AuthenticationRepository>().auth?.username}"),
        Text("Token: ${getIt<AuthenticationRepository>().auth?.token}"),
        ElevatedButton(
            onPressed: () {
              context.read<AuthenticationCubit>().logout();
            },
            child: const Text("Logout")),
        ElevatedButton(
            onPressed: () {
              context.read<DataBloc>().add(ImportDataEvent());
            },
            child: const Text("Import")),
      ]),
    );
  }
}
