import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/pages/post/post_viewer.dart';

class InternshipPage extends StatelessWidget {
  const InternshipPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostViewer(data: getIt<DataRepository>().posts.firstWhere((element) => element.type == 2), withHeader: false,);
  }
}