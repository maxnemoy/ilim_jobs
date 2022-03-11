import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';


class BlocWrapper extends StatelessWidget {
  const BlocWrapper({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationCubit()),
        BlocProvider(create: (_) => DataBloc()),
      ],
      child: child!,
    );
  }
}