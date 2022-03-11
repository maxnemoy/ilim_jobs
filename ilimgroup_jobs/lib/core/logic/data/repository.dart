import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/api/api.dart';
import 'package:ilimgroup_jobs/core/logic/authentication/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';
import 'package:ilimgroup_jobs/data/tmp_import_data/tmp_category.dart';
import 'package:ilimgroup_jobs/data/tmp_import_data/tmp_data.dart';

class DataRepository {
  final ApiClient _client = ApiClient();

  List<VacancyCategoryData>? _vacancyCategories;
  List<VacancyTagData>? _vacancyTags;
  List<VacancyData>? _vacancyData;

  Future<void> importData() async {
    String token = getIt<AuthenticationRepository>().auth?.token ?? "";

    for (String category in tmpData.categories) {
      await _client.createVacancyCategory(
          VacancyCategoryData(category: category, description: ""), token);
    }
    await updateCategories();

    debugPrint(_vacancyCategories?.length.toString());

    for (TmpVacancy vacancy in tmpData.vacancies) {
      await _client.createVacancy(
          VacancyData(
              published: true,
              title: vacancy.title,
              responsibilities: vacancy.responsibilities,
              requirements: vacancy.requirements,
              terms: vacancy.terms,
              tags: [],
              
              category: _vacancyCategories!
                      .firstWhere(
                        (element) => element.category
                            .toLowerCase()
                            .contains(vacancy.description.toLowerCase()),
                        orElse: () =>
                            VacancyCategoryData(category: "", description: ""),
                      )
                      .id ?? 0,
              contacts: vacancy.contacts
                      ),
          token);
    }
    await updateVacancies();

    debugPrint(_vacancyData?.length.toString());
  }

  FutureOr<void> updateCategories() async {
    _vacancyCategories = await _client.getAllVacancyCategories();
  }

  FutureOr<void> updateVacancies() async {
    _vacancyData = await _client.getAllVacancies();
  }
}
