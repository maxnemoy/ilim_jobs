import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/page_header.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:routemaster/routemaster.dart';

class CommentManager extends StatelessWidget {
  const CommentManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            PageHeader(
              title: "Менеджер отзывов",
              actions: [IconButton(onPressed: () {
                Routemaster.of(context)
                              .push("/comment_manager/edit/-1");
              }, icon: const Icon(Icons.add))],
            ),
            Expanded(
                child: ListView(
              children: getIt<DataRepository>()
                  .comments
                  .map((e) => ListTile(
                        title: Text(e.username),
                        onTap: () {
                          Routemaster.of(context)
                              .push("/comment_manager/edit/${e.id}");
                        },
                      ))
                  .toList(),
            ))
          ],
        ));
  }
}
