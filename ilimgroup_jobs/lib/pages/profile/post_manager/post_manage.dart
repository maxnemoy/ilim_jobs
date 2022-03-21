import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/page_header.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zefyr/zefyr.dart';

class PostManager extends StatelessWidget {
  const PostManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(
          title: "Управление записями",
          actions: [IconButton(onPressed: (){
            Routemaster.of(context)
                            .push("/profile/post_manager/edit/-1");
          }, icon: const Icon(Icons.post_add_rounded)),]
        ),
        Expanded(
          child: ListView(
            children: getIt<DataRepository>()
                .posts
                .map((e) => ListTile(
                      onTap: () {
                        Routemaster.of(context)
                            .push("/profile/post_manager/edit/${e.id}");
                      },
                      leading: const Icon(Icons.notes),
                      title: Row(
                        children: [
                          Text(e.title),
                          if(e.type == 2) const Icon(Icons.warning_amber_rounded)
                        ],
                      ),
                      subtitle: ConstrainedBox(constraints: const BoxConstraints(maxHeight: 20), child: Text(NotusDocument.fromJson(jsonDecode(e.body)).toPlainText(), overflow: TextOverflow.ellipsis,)),
                      trailing: const Text("**:**"),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
