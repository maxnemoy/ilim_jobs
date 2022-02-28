import 'package:ilimgroup_jobs/data/categories.dart';

class VacancyDetailData {
  final String title;
  final String description;
  final bool isRecommended;
  final VacancyCategoryData catecory;

  VacancyDetailData({
    required this.title, 
    required this.description,
    required this.catecory,
    this.isRecommended = false});
}