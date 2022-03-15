import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/utils.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:routemaster/routemaster.dart';

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
  late VacancyData data;
  @override
  void initState() {
    data = getIt<DataRepository>().vacancies[int.parse(widget.index)];
    super.initState();
  }


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
                  SizedBox(height: 25),
                  // SizedBox(
                  //   height: 279,
                  //   child: ListView(
                  //     physics: const BouncingScrollPhysics(),
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       const SizedBox(width: 28),
                  //       Container(
                  //         height: 280,
                  //         width: 280,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           image: DecorationImage(
                  //             fit: BoxFit.cover,
                  //             image: AssetImage("assets/pics/pic1.png"),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(width: 20),
                  //       Container(
                  //         height: 280,
                  //         width: 280,
                  //         decoration: BoxDecoration(
                  //           color: Colors.blue,
                  //           borderRadius: BorderRadius.circular(20),
                  //           image: DecorationImage(
                  //             fit: BoxFit.cover,
                  //             image: AssetImage(
                  //               "assets/pics/pic2.jpg",
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: _TagsBar(),
                  ),
                  const SizedBox(height: 46),
                  VacancyDetailPart(title: "Обязанности", data: data.responsibilities,),
                  VacancyDetailPart(title: "Требования", data: data.requirements,),
                  VacancyDetailPart(title: "Условия", data: data.terms,),
                  VacancyDetailPart(title: "Контактная информация", data: data.contacts?[0] ?? "",),
                ],
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 22, right: 22, top: 20, bottom: 10),
                      child: PageHeader(),
                    ),
                  )),
              const Align(
                alignment: Alignment.bottomCenter,
                child: _BottomBar(),
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
  final String title;
  final String data;
  const VacancyDetailPart({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge,),
          Text(
            data,
            style: TextStyle(
                color: const Color(0xffffffff).withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _TagsBar extends StatelessWidget {
  const _TagsBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Center(child: Icon(Icons.telegram)),
        ),
        SizedBox(width: 16),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Center(child: Icon(Icons.r_mobiledata)),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: ElevatedButton(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Откликнуться",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  final bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(360),
            onTap: () {
              Routemaster.of(context).pop();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
              ),
              child: const Center(
                child: Icon(Icons.chevron_left),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(360),
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
              ),
              child: Center(
                child: Icon(
                  Icons.heart_broken,
                  color: isHeartIconTapped!
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
