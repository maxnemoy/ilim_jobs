import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/request/vacancy_request_data.dart';

class ResponseManage extends StatefulWidget {
  final String vacancyId;
  const ResponseManage({Key? key, required this.vacancyId}) : super(key: key);

  @override
  State<ResponseManage> createState() => _ResponseManageState();
  int get id => int.parse(vacancyId);
}

class _ResponseManageState extends State<ResponseManage> {
  late List<VacancyRequestData> list;

  @override
  void initState() {
    list = getIt<DataRepository>()
        .requests
        .where((element) => element.vacancyId == widget.id)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: list
            .map((e) => ListTile(
                  title: Text(e.userId.toString()),
                ))
            .toList(),
      ),
    );
  }
}
