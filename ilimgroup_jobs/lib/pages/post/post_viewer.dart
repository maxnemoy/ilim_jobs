import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/components/horizontal_swipe.dart';
import 'package:ilimgroup_jobs/components/page_header.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:ilimgroup_jobs/pages/post/post_tile.dart';
import 'package:zefyr/zefyr.dart';

class PostViewer extends StatefulWidget {
  const PostViewer({Key? key, this.index, this.data, this.withHeader = true})
      : super(key: key);
  final String? index;
  final PostData? data;
  final bool withHeader;
  @override
  _DetailPageState createState() => _DetailPageState();

  int get indexInt => int.parse(index ?? "-1");
}

class _DetailPageState extends State<PostViewer> {
  late PostData data;
  @override
  void initState() {
    if (widget.data != null) {
      data = widget.data!;
    } else {
      data = getIt<DataRepository>()
          .posts
          .firstWhere((element) => element.id == widget.indexInt);
    }
    super.initState();
  }

  final ScrollController scrollControllerPhotos = ScrollController();
  final ScrollController scrollControllerPosts = ScrollController();
  final FocusNode focus = FocusNode(canRequestFocus: false);
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
                        child: ScrollConfiguration(
                          behavior: HorizontalSwipe(),
                          child: ListView(
                            controller: scrollControllerPhotos,
                            padding: const EdgeInsets.only(left: 28),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: data.assets
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 600,
                                                              maxHeight: 400),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close))
                                                            ],
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  Image.network(
                                                            e,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          )),
                                                        ],
                                                      )),
                                                ));
                                      },
                                      child: Container(
                                        height: 280,
                                        width: 280,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(e),
                                          ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 20),
                    child: ZefyrEditor(
                      //autofocus: true,
                      //expands: true,
                      readOnly: true,
                      showCursor: false,
                      focusNode: focus,
                      controller: ZefyrController(
                          NotusDocument.fromJson(jsonDecode(data.body))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!widget.withHeader)
                    const Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: ZoneTitle(text: "Интересное по теме:"),
                    ),
                  if (!widget.withHeader)
                    const SizedBox(
                      height: 20,
                    ),
                  if (!widget.withHeader)
                    SizedBox(
                      height: 150,
                      child: Scrollbar(
                        controller: scrollControllerPosts,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 28),
                          child: ScrollConfiguration(
                            behavior: HorizontalSwipe(),
                            child: ListView(
                              controller: scrollControllerPosts,
                              padding: const EdgeInsets.only(left: 28),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: getIt<DataRepository>()
                                  .posts
                                  .map(
                                    (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: PostTile(
                                          data: e,
                                        )),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.withHeader)
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, top: 20, bottom: 10),
                        child: PageHeader(
                          actions: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite))
                          ],
                        ),
                      ),
                    )),
              // if(!widget.withHeader) const Align(
              //   alignment: Alignment.bottomCenter,
              //   child: _BottomBar(),
              // ),
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
        child: Container());
  }
}
