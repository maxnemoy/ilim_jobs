import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:routemaster/routemaster.dart';

class PostManager extends StatefulWidget {
  final PostData? data;
  const PostManager({Key? key, this.data}) : super(key: key);

  @override
  State<PostManager> createState() => _PostManagerState();
}

class _PostManagerState extends State<PostManager> {
  ApiClient client = ApiClient();
  late PostData data;

  bool isExpand = false;

  @override
  void initState() {
    data = widget.data ??
        PostData(
            published: true,
            title: "",
            body: "",
            cover: "",
            assets: [],
            type: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
      body: Column(
        children: [
          TextField(
            onChanged: (value) => data = data.copyWith(title: value),
            decoration: const InputDecoration(hintText: "Заголовок статьи"),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) => data = data.copyWith(body: value),
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Напишите что-нибудь....",
                  border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.onBackground.withAlpha(30),
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
                          String link = await pickFileAndUpload();
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                onPressed: () {
                  context.read<DataBloc>().add(SavePostEvent(data,
                      getIt<AuthenticationRepository>().auth?.token ?? ""));
                },
                child: const Text("Сохранить")),
          )
        ],
      ),
    );
  }
}
