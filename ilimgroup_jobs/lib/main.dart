import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/bloc.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/pages/auth/auth_page.dart';
import 'package:ilimgroup_jobs/pages/discover/discover_page.dart';
import 'package:ilimgroup_jobs/pages/home_page.dart';
import 'package:ilimgroup_jobs/pages/internship/internship.dart';
import 'package:ilimgroup_jobs/pages/not_found/not_found.dart';
import 'package:ilimgroup_jobs/pages/post/post_manage.dart';
import 'package:ilimgroup_jobs/pages/post/post_viewer.dart';
import 'package:ilimgroup_jobs/pages/profile/profile_page.dart';
import 'package:ilimgroup_jobs/pages/profile/vacancy_editor/vacancy_editor.dart';
import 'package:ilimgroup_jobs/pages/vacancies_viewer/vacancies_viewer.dart';
import 'package:routemaster/routemaster.dart';

import 'config/singleton.dart';

Future<void> main() async {
  await singletonInit();
  runApp(const MyApp());
}

final routes = RouteMap(
  routes: {
    '/': (_) => const TabPage(
          child: HomePage(),
          paths: ['/home', '/internship', '/profile'],
        ),
    '/home': (_)=> const MaterialPage(child: DiscoverPage()),
    '/internship': (_)=> const MaterialPage(child: InternshipPage()),
    '/internship/post/:id': (info)=> MaterialPage(child: PostViewer(index: info.pathParameters["id"] ?? "0")),
    '/internship/manage': (_)=> const MaterialPage(child: PostManager()),
    '/profile': (_)=> getIt<AuthenticationRepository>().auth != null ? const MaterialPage(child: ProfilePage()) : const MaterialPage(child: AuthPage()),
    // TODO: check roles
    '/profile/vacancyEditor': (_)=> getIt<AuthenticationRepository>().auth != null ? MaterialPage(child: VacancyEditor()) : const MaterialPage(child: AuthPage()),
    '/vacancy/:id': (info) => MaterialPage(child: VacanciesViewer(index: info.pathParameters["id"] ?? "0", recommended: info.queryParameters["rec"]!= null ? info.queryParameters["rec"]!.toLowerCase() == "true" : false,)),
  },
  onUnknownRoute: (route){
    return const MaterialPage(child: NotFoundPage());
  }
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocWrapper(
      child: MaterialApp.router(
        theme: ThemeData(colorScheme: const ColorScheme(
          brightness: Brightness.dark, 
          primary:  Color(0xff4A80F0), 
          secondary: Color(0xff4A80F0), 
          surface: Colors.teal,
          background:  Color(0xff121421), 
          error: Colors.amber, 
          onBackground: Color(0xff515979), 
          onError: Colors.green, 
          onPrimary: Colors.white, 
          onSecondary: Colors.white, 
          onSurface: Color(0xff515979), 
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(color: const Color(0xffffffff).withOpacity(0.7)),
          )),
        routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
        routeInformationParser: const RoutemasterParser(),),
    );
  }
}
