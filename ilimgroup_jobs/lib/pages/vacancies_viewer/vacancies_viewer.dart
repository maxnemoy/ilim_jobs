import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/components/page_header.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/tag2icon.dart';
import 'package:ilimgroup_jobs/core/logic/utils/utils.dart';
import 'package:ilimgroup_jobs/core/models/user/auth_data.dart';
import 'package:ilimgroup_jobs/core/models/user/bookmark/bookmark_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/request/vacancy_request_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zefyrka/zefyrka.dart';

class VacanciesViewer extends StatefulWidget {
  const VacanciesViewer(
      {Key? key, required this.index, this.recommended = false})
      : super(key: key);
  final String index;
  final bool recommended;
  @override
  _DetailPageState createState() => _DetailPageState();

  get indexInt => int.parse(index);
}

class _DetailPageState extends State<VacanciesViewer> {
  ApiClient client = ApiClient();
  AuthData? authData;
  late VacancyData data;
  @override
  void initState() {
    data = getIt<DataRepository>().vacancies[int.parse(widget.index)];
    authData = getIt<AuthenticationRepository>().auth;
    addView();
    super.initState();
  }

  FutureOr<void> addView() {
    if (data.id != null) {
      client.vacancyView(data.id!);
    }
  }

  bool get hasFavorite {
    return getIt<AuthenticationRepository>()
            .bookmarks
            .indexWhere((element) => element.vacancyId == data.id!) >
        -1;
  }

  Bookmark get bookmark => getIt<AuthenticationRepository>()
      .bookmarks
      .firstWhere((element) => element.vacancyId == data.id,
          orElse: () => Bookmark(userId: 0, vacancyId: 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 100),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 66,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Hero(
                      tag: widget.recommended
                          ? "vacancyRecommendedDetail${widget.indexInt}"
                          : "vacancyDetail${widget.indexInt}",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(data.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Text(
                      getCategoryNameById(data.category),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: _TagsBar(
                      data: data.tags,
                    ),
                  ),
                  const SizedBox(height: 46),
                  VacancyDetailPart(
                    data: data.body,
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 22, right: 22, top: 20, bottom: 10),
                      child: PageHeader(
                        actions: [
                          IconButton(
                              onPressed: () async {
                                if (authData != null) {
                                  if (!hasFavorite) {
                                    await client.createBookmark(
                                        Bookmark(
                                            userId: authData!.userId,
                                            vacancyId: data.id!),
                                        authData!.token);
                                  } else {
                                    await client.deleteBookmark(
                                        bookmark, authData!.token);
                                  }
                                  await getIt<AuthenticationRepository>()
                                      .getBookmarks();
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Необходимо авторизоваться",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Routemaster.of(context)
                                                        .push("/profile");
                                                  },
                                                  child: const Text("Войти"))
                                            ],
                                          )));
                                }
                              },
                              icon: authData != null
                                  ? Icon(hasFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded)
                                  : const Icon(Icons.favorite_border_rounded))
                        ],
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: _BottomBar(
                  vacancyData: data,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onStartButtonPressed() {}
}

class VacancyDetailPart extends StatelessWidget {
  final String data;
  VacancyDetailPart({Key? key, required this.data}) : super(key: key);

  final FocusNode focus = FocusNode(canRequestFocus: false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ZefyrEditor(
              focusNode: focus,
              readOnly: true,
              showCursor: false,
              controller:
                  ZefyrController(NotusDocument.fromJson(jsonDecode(data))))
        ],
      ),
    );
  }
}

class _TagsBar extends StatelessWidget {
  final List<int> data;
  const _TagsBar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: data
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Tooltip(
                  message: getIt<DataRepository>()
                      .tags
                      .firstWhere((element) => element.id == e)
                      .tag,
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Center(child: Icon(tag2icon(e))),
                  ),
                ),
              ),
            )
            .toList());
  }
}

class _BottomBar extends StatefulWidget {
  final VacancyData vacancyData;
  const _BottomBar({Key? key, required this.vacancyData}) : super(key: key);

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  bool isRequested = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    List<VacancyRequestData> requests = getIt<DataRepository>().requests;
    if (requests.indexWhere(
            (element) => element.vacancyId == widget.vacancyData.id) >
        -1) {
      setState(() {
        isRequested = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBloc, DataState>(
      listener: (context, state) {
        if (state is DataLoadedState) {
          setState(() {
            loadData();
          });
        }
      },
      child: Container(
        height: 87,
        decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(stops: [
              0,
              1
            ], colors: [
              Color(0xff121421),
              Colors.transparent,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xff4A80F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Tooltip(
                  message: isRequested
                      ? "Вы уже отправляли отклик на эту вакансию"
                      : "Отправить отклик",
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      child: Text(
                        "Откликнуться",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: !isRequested
                        ? () {
                            AuthData? authData =
                                getIt<AuthenticationRepository>().auth;
                            if (authData == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Необходимо авторизоваться",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          TextButton(
                                            child: Text("Войти"),
                                            onPressed: () {
                                              Routemaster.of(context)
                                                  .push("/profile");
                                            },
                                          )
                                        ],
                                      )));
                            } else {
                              context.read<DataBloc>().add(
                                  SaveVacancyRequestEvent(
                                      VacancyRequestData(
                                          userId: authData.userId,
                                          vacancyId: widget.vacancyData.id!,
                                          status: 1),
                                      authData.token));
                            }
                          }
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
