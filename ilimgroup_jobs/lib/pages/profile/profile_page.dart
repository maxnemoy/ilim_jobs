import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/resume/resume_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthData auth;

  @override
  void initState() {
    auth = getIt<AuthenticationRepository>().auth!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is NotAuthenticated) {
            Routemaster.of(context).push("/profile");
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 270,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Theme.of(context).colorScheme.onBackground,
                      child: Center(
                          child: Text(
                              getIt<AuthenticationRepository>()
                                      .resume
                                      ?.firstName ??
                                  auth.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PopupMenuButton<String>(
                        onSelected: (v) {
                          switch (v) {
                            case "Выйти":
                              context.read<AuthenticationCubit>().logout();
                              break;
                            default:
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Изменить профиль', 'Выйти'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: _UserAvatar(
                        url: "", //TODO: add support users avatar
                      )),
                ],
              ),
            ),
            auth.type > 1 ? const AdminProfile() : const UserProfile(),
          ],
        ));
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Expanded(
        child: Column(children: [
          TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: [
              Tab(
                icon: Icon(Icons.fact_check),
                text: "Мои отклики",
              ),
              Tab(
                icon: Icon(Icons.collections_bookmark),
                text: "Отложенные вакансии",
              ),
              Tab(
                icon: Icon(Icons.contact_mail_rounded),
                text: "Резюме",
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
                  children: [RespVacancy(), FavoriteVacancy(), ResumeViewer()]))
        ]),
      ),
    );
  }
}

class RespVacancy extends StatelessWidget {
  const RespVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.fact_check,
          size: 60,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        Text(
          "Здесь появятся вакансии, на которые вы отправите отклик.",
          style: Theme.of(context).textTheme.caption,
        )
      ]),
    );
  }
}

class FavoriteVacancy extends StatelessWidget {
  const FavoriteVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.collections_bookmark,
          size: 60,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        Text(
          "Нет отложенных вакансий",
          style: Theme.of(context).textTheme.caption,
        )
      ]),
    );
  }
}

class ResumeViewer extends StatefulWidget {
  const ResumeViewer({Key? key}) : super(key: key);

  @override
  State<ResumeViewer> createState() => _ResumeViewerState();
}

class _ResumeViewerState extends State<ResumeViewer> {
  ResumeData resume = ResumeData();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    initArraysIfNecessary();
    super.initState();
  }

  void initArraysIfNecessary() {
    if (resume.assets == null) {
      resume = resume.copyWith(assets: []);
    }
    if (resume.works == null) {
      resume = resume.copyWith(works: []);
    }
    if (resume.education == null) {
      resume = resume.copyWith(education: []);
    }
    if (resume.categories == null) {
      resume = resume.copyWith(categories: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: firstNameController,
                        decoration: const InputDecoration(label: Text("Имя")),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: lastNameController,
                        decoration:
                            const InputDecoration(label: Text("Фамилия")),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: phoneNameController,
                        decoration:
                            const InputDecoration(label: Text("Телефон")),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: emailNameController,
                        decoration: const InputDecoration(
                            label: Text("Электронная почта")),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: citizenshipController,
                        decoration:
                            const InputDecoration(label: Text("Гражданство")),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: cityNameController,
                        decoration: const InputDecoration(label: Text("Город")),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text("Дата рождения: "),
                          if (resume.birthday == null)
                            if (resume.birthday != null)
                              Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(resume.birthday!),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                          IconButton(
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime.now());
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text("Пол: "),
                          const Spacer(),
                          DropdownButton<String>(
                              value: resume.gender,
                              items: const [
                                DropdownMenuItem(
                                  child: Text("Мужской"),
                                  value: "Мужской",
                                ),
                                DropdownMenuItem(
                                  child: Text("Женский"),
                                  value: "Женский",
                                ),
                              ],
                              onChanged: (v) {
                                setState(() {
                                  resume = resume.copyWith(gender: v);
                                });
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                TextField(
                  maxLines: null,
                  decoration: const InputDecoration(
                      label: Text("Дополнительная информация")),
                  controller: detailController,
                ),
                MultiValuesField(
                  list: resume.education!,
                  title: "Обучение",
                ),
                MultiValuesField(
                  list: resume.works!,
                  title: "Предыдущие места работы",
                ),
                MultiFileField(
                  list: resume.assets!,
                  title: "Сертификаты и документы",
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Сохранить")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiValuesField extends StatefulWidget {
  final List<String> list;
  final String title;
  const MultiValuesField(
      {Key? key, required this.list, this.title = "some zone"})
      : super(key: key);

  @override
  State<MultiValuesField> createState() => _MultiValuesFieldState();
}

class _MultiValuesFieldState extends State<MultiValuesField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: List.from(widget.list.map((e) => ListTile(
              title: Text(e),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  setState(() {
                    widget.list.removeWhere((element) => element == e);
                  });
                },
              ),
            )))
          ..add(TextField(
            controller: controller,
            onEditingComplete: () {
              setState(() {
                widget.list.add(controller.text);
                controller.clear();
              });
            },
            decoration: InputDecoration(
              label: Text(widget.title),
              suffixIcon: const Icon(Icons.add),
            ),
          ))
          ..insert(0, ZoneTitle(text: widget.title)),
      ),
    );
  }
}

class MultiFileField extends StatefulWidget {
  final List<String> list;
  final String title;
  const MultiFileField({Key? key, required this.list, this.title = "some zone"})
      : super(key: key);

  @override
  State<MultiFileField> createState() => _MultiFileFieldState();
}

class _MultiFileFieldState extends State<MultiFileField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              children: List.from(widget.list.map((e) => ListTile(
                    title: Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(5),
                      child: Image.network(e)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.list.removeWhere((element) => element == e);
                        });
                      },
                    ),
                  )))
                // ..add(ElevatedButton.icon(
                //     onPressed: () async {
                //       String path = await pickFileAndUpload(
                //           getIt<AuthenticationRepository>().auth?.token ?? "");
                //       setState(() {
                //         widget.list.add(path);
                //       });
                //     },
                //     label: const Text("Добавить файл"),
                //     icon: const Icon(Icons.attach_file)))
                // ..insert(0, ZoneTitle(text: widget.title)),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminProfile extends StatelessWidget {
  const AdminProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: [
          const ZoneTitle(text: "Панель управления"),
          ListTile(
            leading: const Icon(Icons.person_search_sharp),
            title: const Text("Управление вакансиями"),
            onTap: () {
              Routemaster.of(context).push("/vacancy_manager");
            },
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_rounded),
            title: const Text("Управление постами"),
            onTap: () {
              Routemaster.of(context).push("/post_manager");
            },
          ),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final String url;
  const _UserAvatar({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: BorderSide(
                width: 5, color: Theme.of(context).colorScheme.background)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(42),
            child: SizedBox(
                width: 100,
                height: 100,
                child: url.isEmpty
                    ? const Icon(
                        Icons.account_circle,
                        size: 100,
                      )
                    : Image.network(
                        url,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      )),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
