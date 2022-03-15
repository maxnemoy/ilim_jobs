import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';

class InternshipPage extends StatelessWidget {
  const InternshipPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: getIt<DataRepository>().posts.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(getIt<DataRepository>().posts[index].title),
        subtitle: Text(getIt<DataRepository>().posts[index].body),
      ),
    );
  }
}