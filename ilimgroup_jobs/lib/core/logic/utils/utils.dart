import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';

String getCategoryNameById(int index)=>getIt<DataRepository>().categories.firstWhere((element) => element.id == index, orElse: ()=>VacancyCategoryData(category: "Без категории", description: "")).category;