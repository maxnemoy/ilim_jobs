import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/style_data.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final tabState = TabPage.of(context);
    return  Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: MediaQuery.of(context).size.width < 800
            ? _MobileNavBar(tabState: tabState)
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 800)
              _DesktopNavBar(tabState: tabState),
            Expanded(
              child: TabBarView(
                controller: tabState.controller,
                children: [
                  for (final stack in tabState.stacks)
                    PageStackNavigator(stack: stack),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}

class PageData {
  final String title;
  final String path;
  final IconData icon;

  PageData({required this.title, required this.path, required this.icon});
}

List<PageData> pages = [
  PageData(title: "Главная", path: "/home", icon: Icons.dashboard),
  PageData(
      title: "Стажировка", path: "/internship", icon: Icons.business_sharp),
  PageData(title: "Профиль", path: "/profile", icon: Icons.person),
];

class _DesktopNavBar extends StatelessWidget {
  const _DesktopNavBar({
    Key? key,
    required this.tabState,
  }) : super(key: key);

  final TabPageState tabState;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        backgroundColor: Theme.of(context).colorScheme.background,
        unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        unselectedLabelTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        extended: MediaQuery.of(context).size.width > 1300,
        onDestinationSelected: (v) => tabState.controller.index = v,
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 30,
            width: 30,
            child: AnimatedSwitcher(duration: const Duration(milliseconds: 100),
            child: MediaQuery.of(context).size.width > 1300 ? Image.asset("assets/logo.png", filterQuality: FilterQuality.medium,): Image.asset("assets/logo-compact.png", filterQuality: FilterQuality.medium,))),
        ),
        destinations: List.generate(
          pages.length,
          (index) => NavigationRailDestination(
              icon: Center(
                  child: DecoratedBox(
                decoration: tabState.controller.index == index
                    ? StyleData.iconBoxDecoration(context)
                    : const BoxDecoration(),
                child: Icon(pages[index].icon),
              )),
              label: Text(pages[index].title)),
        ),
        selectedIndex: tabState.controller.index);
  }
}

class _MobileNavBar extends StatelessWidget {
  const _MobileNavBar({
    Key? key,
    required this.tabState,
  }) : super(key: key);

  final TabPageState tabState;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        onTap: (value) => tabState.controller.index = value,
        currentIndex: tabState.controller.index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: pages
            .map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: '',
                tooltip: e.title,
                activeIcon: Container(
                  decoration: StyleData.iconBoxDecoration(context),
                  child: Icon(
                    e.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )))
            .toList());
  }
}
