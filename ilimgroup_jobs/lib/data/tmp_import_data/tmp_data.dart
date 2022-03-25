import 'package:ilimgroup_jobs/core/models/post/comments/comment_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';
import 'package:ilimgroup_jobs/core/models/user/user_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_tag_data.dart';

class TmpData {
  final List<VacancyTagData> tags;
  final List<VacancyCategoryData> category;
  final List<UserData> users;
  final List<VacancyData> vacancies;
  final List<PostData> posts;
  final List<CommentData> comments;

  TmpData(
      {required this.tags,
      required this.category,
      required this.users,
      required this.vacancies,
      required this.posts,
      required this.comments,

      });
}

// TmpData tmpData = TmpData(tags: [
//   VacancyTagData(tag: "Первая работа", description: ''),
//   VacancyTagData(tag: "Удаленно", description: ''),
//   VacancyTagData(tag: "Полный рабочий день", description: ''),
//   VacancyTagData(tag: "Частичная занятость", description: ''),
//   VacancyTagData(tag: "Работа вахтовым методом", description: ''),
// ], category: [
//   VacancyCategoryData(category: "PR", description: ""),
//   VacancyCategoryData(category: "Административный персонал", description: ""),
//   VacancyCategoryData(category: "Аудит", description: ""),
//   VacancyCategoryData(category: "Бухгалтерия", description: ""),
//   VacancyCategoryData(category: "Высший менеджмент", description: ""),
//   VacancyCategoryData(category: "Геодезист", description: ""),
//   VacancyCategoryData(category: "Закупки", description: ""),
//   VacancyCategoryData(category: "Инвестиции", description: ""),
//   VacancyCategoryData(category: "Информационные технологии", description: ""),
//   VacancyCategoryData(
//       category: "Охрана труда и пожарная безопасность", description: ""),
//   VacancyCategoryData(category: "Продажи", description: ""),
//   VacancyCategoryData(category: "Производство", description: ""),
//   VacancyCategoryData(category: "Стратегия", description: ""),
//   VacancyCategoryData(category: "Управление персоналом", description: ""),
//   VacancyCategoryData(
//       category: "Управление цепочкой поставок и логистика", description: ""),
//   VacancyCategoryData(category: "Финансы", description: ""),
//   VacancyCategoryData(category: "Энергетика", description: ""),
//   VacancyCategoryData(category: "Юристы", description: ""),
// ], users: [
//   UserData(username: "admin", password: "admin", type: 5),
//   UserData(
//     username: "user",
//     password: "user",
//   )
// ], vacancies: [
  
// ]);
