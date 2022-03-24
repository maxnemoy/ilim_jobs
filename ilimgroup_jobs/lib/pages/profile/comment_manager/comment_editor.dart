import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/components/user_avatar.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/post/comments/comment_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zefyrka/zefyrka.dart';

class CommentEditor extends StatefulWidget {
  final String? index;
  const CommentEditor({Key? key, this.index}) : super(key: key);

  @override
  State<CommentEditor> createState() => _CommentEditorState();

  int get comment_id => int.parse(index ?? "-1");
}

class _CommentEditorState extends State<CommentEditor> {
  late CommentData comment;

  late TextEditingController _nameController;
  late ZefyrController _controller;

  @override
  void initState() {
    comment = getIt<DataRepository>().comments.firstWhere(
        (element) => element.id == widget.comment_id,
        orElse: () => CommentData(avatar: '', body: '', username: ''));
    _nameController = TextEditingController(text: comment.username);
    if (comment.body.isNotEmpty) {
      _controller =
          ZefyrController(NotusDocument.fromJson(jsonDecode(comment.body)));
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
          title: const Text("Управление отзывом"),
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
        body: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(label: Text("Имя")),
            ),
            const ZoneTitle(text: "Фото пользователя"),
            UserAvatar(
              url: comment.avatar,
            ),
            ElevatedButton(
                onPressed: () async {
                  String path = await pickFileAndUpload(
                      getIt<AuthenticationRepository>().auth?.token ?? "");
                  setState(() {
                    comment = comment.copyWith(avatar: path);
                  });
                },
                child: const Text("Загрузить фото")),
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
            BlocListener<DataBloc, DataState>(
              listener: (context, state) {
                if (state is DataSavedState) Routemaster.of(context).pop();
              },
              child: ElevatedButton(
                  onPressed: () {
                    comment = comment.copyWith(
                        username: _nameController.text,
                        body: jsonEncode(_controller.document.toJson()));
            
                    context.read<DataBloc>().add(SaveCommentEvent(comment,
                        getIt<AuthenticationRepository>().auth?.token ?? ""));
                  },
                  child: const Text("Сохранить")),
            )
          ],
        ));
  }
}
