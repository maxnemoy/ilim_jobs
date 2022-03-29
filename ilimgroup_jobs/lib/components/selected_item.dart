import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/config/singleton.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_category_data.dart';

class SelectedItem extends StatelessWidget {
  final Function(bool isSelected)? onPressed;
  final VacancyCategoryData? category;

  const SelectedItem({Key? key, this.onPressed, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var selected =
        getIt<DataRepository>()
        .checkSelectedCategoryItem(category?.id ?? -1) > -1;
    return Center(
      child: GestureDetector(
        onTap: () {
          onPressed?.call(selected);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  selected ? 
                  Theme.of(context).colorScheme.onBackground : 
                  Theme.of(context).colorScheme.surface,
              boxShadow: selected
                  ? [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 10),
                    ]
                  : [],
            ),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Text(
                  category?.category ?? "",
                  style: !selected ? TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.normal) : TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
