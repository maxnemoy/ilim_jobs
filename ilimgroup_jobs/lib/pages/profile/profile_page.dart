import 'dart:io' if (dart.library.js) 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/models/response_data.dart';
import 'package:routemaster/routemaster.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? file;
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
        ElevatedButton(
            onPressed: () {
              Routemaster.of(context).push("/profile/vacancyEditor");
            },
            child: const Text("Add vacancy")),
        ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                setState(() {
                  file = File(result.files.single.path!);
                });
              }
            },
            child: const Text("Choose file")),
        if (file != null)
          ElevatedButton(
              onPressed: () async {
                ApiClient client = ApiClient();
                RespData data = await client.uploadFile(
                    file!, getIt<AuthenticationRepository>().auth?.token ?? "");
                print(data.path);
              },
              child: const Text("UploadFile"))
      ]),
    );
  }
}
