import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/page_header.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:routemaster/routemaster.dart';

class VacancyManager extends StatelessWidget {
  const VacancyManager({Key? key}) : super(key: key);

  int requestsCount(VacancyData vac){
    return getIt<DataRepository>().requests.where((element) => element.vacancyId == vac.id).length;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          PageHeader(
            actions: [IconButton(onPressed: () {
              Routemaster.of(context)
                              .push("/vacancy_manager/edit/-1");
            }, icon: const Icon(Icons.add))],
          ),
          Expanded(
            child: ListView(
              children: getIt<DataRepository>()
                  .vacancies
                  .map((e) => ListTile(
                        title: Text(e.title),
                        subtitle: Text("Просмотров: ${e.views}"),
                        trailing: Text(requestsCount(e).toString()),
                        onTap: () {
                          Routemaster.of(context)
                              .push("/vacancy_manager/edit/${e.id}");
                        },
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
