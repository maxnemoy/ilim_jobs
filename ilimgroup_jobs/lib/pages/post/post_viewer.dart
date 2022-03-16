import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:ilimgroup_jobs/pages/post/post_tile.dart';
import 'package:ilimgroup_jobs/pages/vacancies_viewer/vacancies_viewer.dart';

class PostViewer extends StatefulWidget {
  const PostViewer({Key? key, required this.index}) : super(key: key);
  final String index;
  @override
  _DetailPageState createState() => _DetailPageState();

  int get indexInt => int.parse(index);
}

class _DetailPageState extends State<PostViewer> {
  late PostData data;
  @override
  void initState() {
    data = getIt<DataRepository>()
        .posts
        .firstWhere((element) => element.id == widget.indexInt);
    super.initState();
  }
  final ScrollController scrollControllerPhotos = ScrollController();
  final ScrollController scrollControllerPosts = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 100),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 66,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(data.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 279,
                    child: Scrollbar(
                      controller: scrollControllerPhotos,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: ListView(
                          controller: scrollControllerPhotos,
                          padding: const EdgeInsets.only(left: 28),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: data.assets
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    height: 280,
                                    width: 280,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(e),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    child: Text(data.body, style: Theme.of(context).textTheme.bodyText2,),
                  ),
                  
                  const SizedBox(height: 20,),
                 const  Padding(
                    padding:  EdgeInsets.only(left: 28),
                    child:  ZoneTitle(text: "Интересное по теме:"),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 150,
                    child: Scrollbar(
                      controller: scrollControllerPosts,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: ListView(
                          controller: scrollControllerPosts,
                          padding: const EdgeInsets.only(left: 28),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: getIt<DataRepository>().posts
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: PostTile(data: e,)
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],  
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 22, right: 22, top: 20, bottom: 10),
                      child: PageHeader(),
                    ),
                  )),
              const Align(
                alignment: Alignment.bottomCenter,
                child: _BottomBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStartButtonPressed() {}
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      decoration: const BoxDecoration(
          color: Colors.black,
          gradient: LinearGradient(stops: [
            0,
            1
          ], colors: [
            Color(0xff121421),
            Colors.transparent,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      child: Container()
    );
  }
}
