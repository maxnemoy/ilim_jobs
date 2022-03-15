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

// ignore: must_be_immutable
class VacancyEditor extends StatefulWidget {
  late VacancyData? data;
  VacancyEditor({Key? key, this.data}) : super(key: key) {
    data ??= VacancyData(
        category: 1,
        published: true,
        description: "",
        requirements: '',
        responsibilities: '',
        tags: [],
        terms: '',
        title: '');
  }

  @override
  State<VacancyEditor> createState() => _VacancyEditorState();
}

class _VacancyEditorState extends State<VacancyEditor> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _responsibilitiesController;
  late TextEditingController _requirementsController;
  late TextEditingController _termsController;
  late TextEditingController _contactsController;
  VacancyData? data;

  @override
  void initState() {
    data = widget.data;
    _titleController = TextEditingController(text: widget.data?.title);
    _descriptionController = TextEditingController(text: data?.description);
    _responsibilitiesController =
        TextEditingController(text: data?.responsibilities);
    _requirementsController = TextEditingController(text: data?.requirements);
    _termsController = TextEditingController(text: data?.terms);
    _contactsController = TextEditingController(text: data?.contacts?[0]);
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
                    const ZoneTitle(text: 'Общие сведения',),
                     TextField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(label: Text("Название")),
                      onChanged: (v) => data = data?.copyWith(title: v),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(label: Text("Описание")),
                      maxLines: null,
                      onChanged: (v) => data = data?.copyWith(description: v),
                    ),
                    const SizedBox(height: 20,),         
                    const ZoneTitle(text: 'Тип вакансии',),
                    Row(
                      children: [
                        const Text("Категория "),
                        const Spacer(),
                        DropdownButton<int>(
                            underline: Container(width: double.infinity, height: 0.5, color: Theme.of(context).colorScheme.onBackground,),
                            focusColor: Theme.of(context).colorScheme.background,
                            dropdownColor: Theme.of(context).colorScheme.background,
                            value: data?.category,
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
                                data = data?.copyWith(category: e);
                              });
                            }),
                      ],
                    ),
                    const SizedBox(height: 20,), 
                    Row(
                      children: [
                        const Text("Формат работы "),
                        const SizedBox(width: 20,),
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
                                            side: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 0.5),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                              
                                          selectedColor:
                                              Theme.of(context).colorScheme.primary,
                                          onSelected: (element) {
                                            int index = data?.tags.indexWhere(
                                                    (element) => element == e.id) ??
                                                -1;
                                            if (index > -1) {
                                              data?.tags.removeAt(index);
                                            } else {
                                              data?.tags.add(e.id!);
                                            }
                                            setState(() {});
                                          },
                                          label: Text(e.tag),
                                          selected: data!.tags
                                                  .indexWhere((el) => el == e.id) >
                                              -1,
                                        ),
                                      ))
                                  .toList()),
                        ),
                      ],
                    ),
                   const SizedBox(height: 20,), 
                    const ZoneTitle(text: 'Детальная информация',),
                    TextField(
                      controller: _responsibilitiesController,
                      decoration:
                          const InputDecoration(label: Text("Обязанности")),
                      maxLines: null,
                      onChanged: (v) =>
                          data = data?.copyWith(responsibilities: v),
                    ),
                    TextField(
                      controller: _requirementsController,
                      decoration:
                          const InputDecoration(label: Text("Требования")),
                      maxLines: null,
                      onChanged: (v) => data = data?.copyWith(requirements: v),
                    ),
                    TextField(
                      controller: _termsController,
                      decoration: const InputDecoration(label: Text("Условия")),
                      maxLines: null,
                      onChanged: (v) => data = data?.copyWith(terms: v),
                    ),
                    TextField(
                      controller: _contactsController,
                      decoration: const InputDecoration(
                          label: Text("Контактная информация")),
                      maxLines: null,
                      onChanged: (v) => data = data?.copyWith(contacts: [v]),
                    ),

                    Row(
                      children: [
                        const Text("Опубликовать при сохранении"),
                        const Spacer(),
                        Switch(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: data?.published ?? false,
                            onChanged: (v) => setState(() {
                                  data = data?.copyWith(published: v);
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
                                context.read<DataBloc>().add(SaveVacancyEvent(data!, getIt<AuthenticationRepository>().auth?.token ?? ""));
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
