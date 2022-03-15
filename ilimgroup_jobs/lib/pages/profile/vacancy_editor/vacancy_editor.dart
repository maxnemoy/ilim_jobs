import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
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
    _descriptionController =
        TextEditingController(text: widget.data?.description);
    _responsibilitiesController =
        TextEditingController(text: widget.data?.responsibilities);
    _requirementsController =
        TextEditingController(text: widget.data?.requirements);
    _termsController = TextEditingController(text: widget.data?.terms);
    _contactsController =
        TextEditingController(text: widget.data?.contacts?[0]);
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Switch(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: data?.published ?? false, onChanged: (v)=>setState(() {
                      data = data?.copyWith(published: v);
                    })),
                    DropdownButton<int>(
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
                    Wrap(children: getIt<DataRepository>().tags.map((e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ChoiceChip(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (element){
                          int index = data?.tags.indexWhere((element) => element == e.id) ?? -1;
                            if (index > -1) {
                              data?.tags.removeAt(index);
                            } else {
                              data?.tags.add(e.id!);
                            }
                            setState(() {
                              
                            });
                        },
                        label: Text(e.tag), selected: data!.tags.indexWhere((el)=>el == e.id) > -1,),
                    )).toList()),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(label: Text("Название")),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(label: Text("Описание")),
                      maxLines: null,
                    ),
                    TextField(
                      controller: _responsibilitiesController,
                      decoration:
                          const InputDecoration(label: Text("Обязанности")),
                      maxLines: null,
                    ),
                    TextField(
                      controller: _requirementsController,
                      decoration:
                          const InputDecoration(label: Text("Требования")),
                      maxLines: null,
                    ),
                    TextField(
                      controller: _termsController,
                      decoration: const InputDecoration(label: Text("Условия")),
                      maxLines: null,
                    ),
                    TextField(
                      controller: _contactsController,
                      decoration: const InputDecoration(
                          label: Text("Контактная информация")),
                      maxLines: null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Сохранить")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
