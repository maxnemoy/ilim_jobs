import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/tag2icon.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zefyr/zefyr.dart';

// ignore: must_be_immutable
class VacancyEditor extends StatefulWidget {
  String? id;
  VacancyEditor({Key? key, this.id}) : super(key: key);

  int get vacancyId => int.parse(id ?? "-1");

  @override
  State<VacancyEditor> createState() => _VacancyEditorState();
}

class _VacancyEditorState extends State<VacancyEditor> {
  late TextEditingController _titleController;
  late ZefyrController _bodyController;
  late VacancyData data;

  @override
  void initState() {
    data = getIt<DataRepository>().vacancies.firstWhere(
        (element) => element.id == widget.vacancyId,
        orElse: () => VacancyData(
            category: 1, published: true, body: "", tags: [], title: ''));

    _titleController = TextEditingController(text: data.title);
    if (data.body.isNotEmpty) {
      _bodyController =
          ZefyrController(NotusDocument.fromJson(jsonDecode(data.body)));
    } else {
      _bodyController = ZefyrController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Добавить вакансию"),
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const ZoneTitle(
                      text: 'Общие сведения',
                    ),
                    TextField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(label: Text("Название")),
                      onChanged: (v) => data = data.copyWith(title: v),
                    ),
                    const ZoneTitle(
                      text: 'Тип вакансии',
                    ),
                    Row(
                      children: [
                        const Text("Категория "),
                        const Spacer(),
                        DropdownButton<int>(
                            underline: Container(
                              width: double.infinity,
                              height: 0.5,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            focusColor:
                                Theme.of(context).colorScheme.background,
                            dropdownColor:
                                Theme.of(context).colorScheme.background,
                            value: data.category,
                            items: getIt<DataRepository>()
                                .categories
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.category),
                                    ))
                                .toList(),
                            onChanged: (e) {
                              // widget.data.category = e;
                              setState(() {
                                data = data.copyWith(category: e);
                              });
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text("Формат работы "),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Wrap(
                              alignment: WrapAlignment.center,
                              children: getIt<DataRepository>()
                                  .tags
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ChoiceChip(
                                          avatar: Icon(tag2icon(e.id ?? -1)),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          selectedColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          onSelected: (element) {
                                            int index = data.tags.indexWhere(
                                                (element) => element == e.id);
                                            if (index > -1) {
                                              data.tags.removeAt(index);
                                            } else {
                                              data.tags.add(e.id!);
                                            }
                                            setState(() {});
                                          },
                                          label: Text(e.tag),
                                          selected: data.tags.indexWhere(
                                                  (el) => el == e.id) >
                                              -1,
                                        ),
                                      ))
                                  .toList()),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ZoneTitle(
                      text: 'Детальная информация',
                    ),
                    Container(
                      height: 500,
                      child: Column(
                        children: [
                          ZefyrToolbar.basic(controller: _bodyController),
                          Expanded(
                            child: ZefyrEditor(
                              focusNode: FocusNode(),
                              controller: _bodyController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Опубликовать при сохранении"),
                        const Spacer(),
                        Switch(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: data.published,
                            onChanged: (v) => setState(() {
                                  data = data.copyWith(published: v);
                                })),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                data = data.copyWith(
                                    body: jsonEncode(
                                        _bodyController.document.toJson()));
                                context.read<DataBloc>().add(SaveVacancyEvent(
                                    data,
                                    getIt<AuthenticationRepository>()
                                            .auth
                                            ?.token ??
                                        ""));
                              },
                              child: const Text("Сохранить")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
