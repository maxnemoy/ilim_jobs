import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilimgroup_jobs/components/selected_item.dart';
import 'package:ilimgroup_jobs/components/vacancy_card.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/utils.dart';
import 'package:ilimgroup_jobs/data/example_data.dart';
import 'package:routemaster/routemaster.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: Drawer(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 28, right: 18, top: 36),
              child: _DiscoveryHeader(),
            ),
            SizedBox(
              height: 100,
              child: _CategoriesView(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),
              child: _ZoneTitle(
                text: "Рекомендации",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 200,
              child: _RecommendationListView(
                key: const ValueKey("recommendationListView"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: _ZoneTitle(
                text: "Новые",
                onShowAllClick: () {
                  print("showAll new vacancies");
                },
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: _VacanciesList(),
            )
          ],
        ),
      ),
    );
  }
}

class _VacanciesList extends StatelessWidget {
  const _VacanciesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        if (state is DataInitialState) {
          context.read<DataBloc>().add(LoadDataEvent());
        }
        if (state is DataIsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DataLoadedState) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 250),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16.0),
              itemCount: getIt<DataRepository>().vacancies.length,
              itemBuilder: (context, index) => VacancyCard(
                    tag: "vacancyDetail$index",
                    onTap: () {
                      Routemaster.of(context).push("/vacancy/$index");
                    },
                    title: getIt<DataRepository>().vacancies[index].title,
                    gradientStartColor: Color(0xffFC67A7),
                    gradientEndColor: Color(0xffF6815B),
                  ));
        }
        return Container();
      },
    );
  }
}

class _RecommendationListView extends StatelessWidget {
  _RecommendationListView({Key? key, ScrollController? scrollController})
      : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      if (state is DataLoadedState) {
        return Scrollbar(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.separated(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: getIt<DataRepository>().vacancies.length,
              itemBuilder: (context, index) {
                  return VacancyCard(
                    isRecommended: true,
                    tag: "vacancyRecommendedDetail$index",
                    onTap: () {
                      Routemaster.of(context).push('/vacancy/$index?rec=true');
                    },
                    title:  getIt<DataRepository>().vacancies[index].title,
                    subtitle: getCategoryNameById(getIt<DataRepository>().vacancies[index].category),
                  );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),
        );
      }
      return Container();
    });
  }
}

class _DiscoveryHeader extends StatelessWidget {
  const _DiscoveryHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const SizedBox(
                height: 35,
                width: 35,
                child: Center(child: Icon(Icons.menu)),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(360),
              onTap: () {
                print("search");
              },
              child: const SizedBox(
                height: 35,
                width: 35,
                child: Center(child: Icon(Icons.search)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Text("Найди работу своей мечты",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 34,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}

class _ZoneTitle extends StatelessWidget {
  const _ZoneTitle(
      {Key? key, required this.text, this.showAllText, this.onShowAllClick})
      : super(key: key);

  final String text;
  final String? showAllText;
  final VoidCallback? onShowAllClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
        if (onShowAllClick != null)
          TextButton(
              onPressed: () => onShowAllClick!(),
              child: Text(showAllText ?? "Все"))
      ],
    );
  }
}

class _CategoriesView extends StatelessWidget {
  _CategoriesView({Key? key, ScrollController? controller})
      : controller = controller ?? ScrollController(),
        super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      if (state is DataLoadedState) {
        return Scrollbar(
          controller: controller,
          child: ListView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              children: getIt<DataRepository>().categories
                  .map((e) => SelectedItem(
                        text: e.category,
                        onPressed: (value) => print(value),
                      ))
                  .toList()),
        );
      }
      return Container();
    });
  }
}
