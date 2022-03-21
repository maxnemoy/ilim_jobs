import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:ilimgroup_jobs/pages/post/post_viewer.dart';

class InternshipPage extends StatefulWidget {
  const InternshipPage({Key? key}) : super(key: key);

  @override
  State<InternshipPage> createState() => _InternshipPageState();
}

class _InternshipPageState extends State<InternshipPage> {
  late int indexMainPost;

  @override
  void initState() {
    indexMainPost = getIt<DataRepository>()
        .posts
        .indexWhere((element) => element.type == 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (indexMainPost > -1) {
      return PostViewer(
        data: getIt<DataRepository>().posts[indexMainPost],
        withHeader: false,
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(
            Icons.art_track,
            color: Theme.of(context).colorScheme.onBackground,
            size: 60,
          ),
          Text("Что-то пошло не так.", style: Theme.of(context).textTheme.caption,)
        ]),
      );
    }
  }
}
