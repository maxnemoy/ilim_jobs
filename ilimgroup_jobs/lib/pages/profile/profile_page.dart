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
                          child: Text(auth.username,
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
                          print(v);
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
                        url:
                            "https://i.pinimg.com/564x/cb/6f/59/cb6f59b87ceac24b3410e2a656ae4231.jpg",
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  const ZoneTitle(text: "Панель управления"),
                  ListTile(
                    leading: const Icon(Icons.person_search_sharp),
                    title: const Text("Управление вакансиями"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.note_alt_rounded),
                    title: const Text("Управление постами"),
                    onTap: () {
                      Routemaster.of(context).push("/profile/post_manager");
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
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
                child: Image.network(
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
