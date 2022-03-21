import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/cubit.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
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

class ResumeViewer extends StatelessWidget {
  const ResumeViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Имя")),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Фамилия")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Телефон")),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Город")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Гражданство")),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Город")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(DateTime.now().toString()),
                    ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now());
                        },
                        child: Text("Дата Рожения")),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text("Пол"),
                    Spacer(),
                    DropdownButton<String>(
                        value: "Мужской",
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
                        onChanged: (v) {}),
                  ],
                ),
              )
            ],
          ),
          TextField(
            maxLines: null,
            decoration: InputDecoration(label: Text("Дополнительная информация")),
          ),
          MultiValuesField(
            list: [],
          )
        ],
      ),
    );
  }
}

class MultiValuesField extends StatefulWidget {
  final List<String> list;
  const MultiValuesField({Key? key, required this.list}) : super(key: key);

  @override
  State<MultiValuesField> createState() => _MultiValuesFieldState();
}

class _MultiValuesFieldState extends State<MultiValuesField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.from(widget.list.map((e) => ListTile(
            title: Text(e),
          )))
        ..add(TextField(
          controller: controller,
          onEditingComplete: () {
            setState(() {
              widget.list.add(controller.text);
            });
          },
          decoration: const InputDecoration(
            label: Text("SomeLabel"),
            suffixIcon: Icon(Icons.add),
          ),
        )),
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
