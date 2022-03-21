import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zefyr/zefyr.dart';

class PostEditor extends StatefulWidget {
  final String? id;
  const PostEditor({Key? key, this.id}) : super(key: key);

  @override
  State<PostEditor> createState() => _PostEditorState();

  int get postId => int.parse(id ?? "-1");
}

class _PostEditorState extends State<PostEditor> {
  ApiClient client = ApiClient();
  late PostData data;
  late ZefyrController _controller;
  late TextEditingController _titleController;

  bool isExpand = false;

  @override
  void initState() {
    data = getIt<DataRepository>().posts.firstWhere(
        (element) => element.id == widget.postId,
        orElse: () => PostData(
            published: true,
            title: "",
            body: "",
            cover: "",
            assets: [],
            type: 1));
    _titleController = TextEditingController(text: data.title);
    if (data.body.isNotEmpty) {
      _controller =
          ZefyrController(NotusDocument.fromJson(jsonDecode(data.body)));
    } else {
      _controller = ZefyrController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Управление записью"),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 26,
            color: Colors.white,
          ),
          onPressed: () {
            Routemaster.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (value) => data = data.copyWith(title: value),
              decoration: const InputDecoration(hintText: "Заголовок статьи"),
            ),
            Expanded(
              child: Column(
                children: [
                  ZefyrToolbar.basic(controller: _controller),
                  Expanded(
                    child: ZefyrEditor(
                      focusNode: FocusNode(),
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: TextField(
            //     onChanged: (value) => data = data.copyWith(body: value),
            //     maxLines: null,
            //     decoration: const InputDecoration(
            //         hintText: "Напишите что-нибудь....",
            //         border: InputBorder.none),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      Theme.of(context).colorScheme.onBackground.withAlpha(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const ZoneTitle(text: "Управление вложениями"),
                            Wrap(
                              children: data.assets
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(
                                          e,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () async {
                            String link = await pickFileAndUpload(
                                getIt<AuthenticationRepository>().auth?.token ??
                                    "");
                            setState(() {
                              data.assets.add(link);
                            });
                          },
                          icon: const Icon(Icons.upload_file_rounded),
                          label: const Text("Добавить изображение"))
                    ],
                  ),
                ),
              ),
            ),
            BlocListener<DataBloc, DataState>(
              listener: (context, state) {
                if (state is DataSavedState) Routemaster.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: () {
                      data = data.copyWith(
                          body: jsonEncode(_controller.document.toJson()));
                      context.read<DataBloc>().add(SavePostEvent(data,
                          getIt<AuthenticationRepository>().auth?.token ?? ""));
                    },
                    child: const Text("Сохранить")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
