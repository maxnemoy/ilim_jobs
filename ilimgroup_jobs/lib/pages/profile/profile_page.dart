import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/components/user_avatar.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/file_uploader.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/bookmark/bookmark_data.dart';
import 'package:ilimgroup_jobs/core/models/user/resume/resume_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
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
  ResumeData? resume;

  @override
  void initState() {
    auth = getIt<AuthenticationRepository>().auth!;
    resume = getIt<AuthenticationRepository>().resume;
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
                              resume != null
                                  ? "${resume!.firstName} ${resume!.lastName}"
                                  : auth.username,
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
                            case "Изменить профиль":
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title:
                                            const Text("Управление профилем"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Закрыть"))
                                        ],
                                        content: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      String? photo =
                                                          await pickFileAndUpload(
                                                              auth.token);

                                                      if (resume != null) {
                                                        resume = resume!
                                                            .copyWith(
                                                                resumeLink:
                                                                    photo);
                                                        context
                                                            .read<
                                                                AuthenticationCubit>()
                                                            .saveResume(
                                                                resume!);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(const SnackBar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                content: Text(
                                                                    "Сначала создайте резюме")));
                                                      }
                                                    },
                                                    child: const Text(
                                                        "Загрузить фото")),
                                                TextField(
                                                  controller: TextEditingController(
                                                      text: getIt<
                                                              AuthenticationRepository>()
                                                          .auth
                                                          ?.username),
                                                  decoration: InputDecoration(
                                                      label: const Text(
                                                          "Имя пользователя"),
                                                      suffix: IconButton(
                                                        icon: const Icon(
                                                            Icons.save),
                                                        onPressed: () {},
                                                      )),
                                                ),
                                                const ZoneTitle(
                                                    text: "Обновить пароль"),
                                                const TextField(),
                                                const TextField()
                                              ]),
                                        ),
                                      ));
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
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: UserAvatar(
                        url: resume?.resumeLink,
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
            tabs: const [
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
          const Expanded(
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

class FavoriteVacancy extends StatefulWidget {
  const FavoriteVacancy({Key? key}) : super(key: key);

  @override
  State<FavoriteVacancy> createState() => _FavoriteVacancyState();
}

class _FavoriteVacancyState extends State<FavoriteVacancy> {
  late List<Bookmark> list;
  late List<VacancyData> vacancies;
  @override
  void initState() {
    list = getIt<AuthenticationRepository>().bookmarks;
    vacancies = getIt<DataRepository>().vacancies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (list.isEmpty)
          Icon(
            Icons.collections_bookmark,
            size: 60,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        if (list.isEmpty)
          Text(
            "Нет отложенных вакансий",
            style: Theme.of(context).textTheme.caption,
          ),
        if (list.isNotEmpty)
          Expanded(
              child: ListView(
            children: list.map((e) {
              VacancyData data = vacancies
                  .firstWhere(((element) => element.id == e.vacancyId));
              return ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () async {
                    ApiClient client = ApiClient();
                    await client.deleteBookmark(
                        e, getIt<AuthenticationRepository>().auth?.token ?? "");

                    await getIt<AuthenticationRepository>().getBookmarks();
                    setState(() {
                      list = getIt<AuthenticationRepository>().bookmarks;
                      vacancies = getIt<DataRepository>().vacancies;
                    });
                  },
                ),
                onTap: () {
                  Routemaster.of(context).push(
                      "/vacancy/${vacancies.indexWhere((element) => element.id == e.vacancyId)}");
                },
                title: Text(data.title),
              );
            }).toList(),
          )),
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
  late ResumeData resume;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNameController;
  late TextEditingController emailNameController;
  late TextEditingController cityNameController;
  late TextEditingController citizenshipController;
  late TextEditingController detailController;

  @override
  void initState() {
    resume = getIt<AuthenticationRepository>().resume ?? ResumeData();
    resume =
        resume.copyWith(userId: getIt<AuthenticationRepository>().auth?.userId);
    initArraysIfNecessary();

    firstNameController = TextEditingController(text: resume.firstName);
    lastNameController = TextEditingController(text: resume.lastName);
    phoneNameController = TextEditingController(text: resume.phone);
    emailNameController = TextEditingController(text: resume.email);
    cityNameController = TextEditingController(text: resume.city);
    citizenshipController = TextEditingController(text: resume.citizenship);
    detailController = TextEditingController(text: resume.about);
    super.initState();
  }

  void initArraysIfNecessary() {
    if (resume.assets == null) {
      resume = resume.copyWith(assets: []);
    }
    if (resume.resumeLink == null) {
      resume = resume.copyWith(resumeLink: "");
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
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is ResumeSaved) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Резюме сохранено"),
            backgroundColor: Colors.green,
          ));
        }
        if (state is ResumeSavedError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Сохранение резюме завершилось ошибкой"),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                          decoration:
                              const InputDecoration(label: Text("Город")),
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
                            if (resume.birthday != null)
                              Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(resume.birthday!),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            IconButton(
                                onPressed: () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1970),
                                      lastDate: DateTime.now());
                                  setState(() {
                                    print(date);
                                    resume = resume.copyWith(birthday: date);
                                  });
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
                  const SizedBox(
                    height: 20,
                  ),
                  CategoryList(
                    list: resume.categories!,
                  ),
                  MultiFileField(
                    list: resume.assets!,
                    title: "Сертификаты и документы",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          resume = resume.copyWith(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              phone: phoneNameController.text,
                              email: emailNameController.text,
                              city: cityNameController.text,
                              citizenship: citizenshipController.text,
                              about: detailController.text);
                          context
                              .read<AuthenticationCubit>()
                              .saveResume(resume);
                        },
                        child: const Text("Сохранить")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  final List<String> list;
  const CategoryList({Key? key, required this.list}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZoneTitle(text: "Предпочитаемые категории"),
        Wrap(
          children: getIt<DataRepository>()
              .categories
              .map((e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.list.indexWhere(
                                (element) => element == e.category) >
                            -1) {
                          widget.list
                              .removeWhere((element) => element == e.category);
                        } else {
                          widget.list.add(e.category);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: ChoiceChip(
                        selectedColor:
                            Theme.of(context).colorScheme.onBackground,
                        disabledColor: Theme.of(context).colorScheme.background,
                        label: Text(e.category),
                        selected: widget.list.indexWhere(
                                (element) => element == e.category) >
                            -1,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
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
          ZoneTitle(text: widget.title),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 100,
              child: GridView.extent(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  maxCrossAxisExtent: 100,
                  children: List.from(widget.list.map((String src) => ImageTile(
                        src: src,
                        onDelete: () {
                          setState(() {
                            widget.list
                                .removeWhere((element) => element == src);
                          });
                        },
                      )))),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                String path = await pickFileAndUpload(
                    getIt<AuthenticationRepository>().auth?.token ?? "");
                setState(() {
                  if (path.isNotEmpty) {
                    widget.list.add(path);
                  }
                });
              },
              label: const Text("Добавить файл"),
              icon: const Icon(Icons.attach_file))
        ],
      ),
    );
  }
}

class ImageTile extends StatefulWidget {
  final String src;
  final VoidCallback? onDelete;
  const ImageTile({Key? key, required this.src, this.onDelete})
      : super(key: key);

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool isHover = false;
  String extension = "";
  @override
  void initState() {
    extension = widget.src.split(".").last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() {
              isHover = !isHover;
            }),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Blur(
                  blur: isHover ? 2.3 : 0,
                  blurColor: Theme.of(context).colorScheme.onBackground,
                  colorOpacity: 0.3,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: extension == "png" ||
                                extension == "jpg" ||
                                extension == "jpeg" ||
                                extension == "gif"
                            ? Image.network(
                                widget.src,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                child: Icon(
                                  Icons.file_present_rounded,
                                  size: 50,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ))),
                  ),
                )),
            if (isHover)
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                      onPressed: () {
                        widget.onDelete?.call();
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.red,
                        size: 30,
                      )))
          ],
        ));
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
          ListTile(
            leading: const Icon(Icons.comment),
            title: const Text("Управление комментариями"),
            onTap: () {
              Routemaster.of(context).push("/comment_manager");
            },
          ),
        ],
      ),
    );
  }
}
