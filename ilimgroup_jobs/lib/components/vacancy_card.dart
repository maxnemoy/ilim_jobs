import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/style_data.dart';
import 'package:ilimgroup_jobs/core/logic/data/repository.dart';
import 'package:ilimgroup_jobs/core/logic/utils/tag2icon.dart';
import 'package:ilimgroup_jobs/core/logic/utils/utils.dart';
import 'package:ilimgroup_jobs/core/models/vacancy/vacancy_data.dart';

import '../config/singleton.dart';

class VacancyCard extends StatefulWidget {
  final VacancyData data;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  final bool isRecommended;
  const VacancyCard(
      {Key? key,
      required this.data,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.tag,
      this.isRecommended = false})
      : super(key: key);

  @override
  State<VacancyCard> createState() => _VacancyCardState();
}

class _VacancyCardState extends State<VacancyCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isHover ? 0 : 5),
      child: DecoratedBox(
        decoration: isHover
            ? StyleData.iconBoxDecoration(context)
            : const BoxDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onHover: (v) {
              setState(() {
                isHover = v;
              });
            },
            onTap: () => widget.onTap!(),
            borderRadius: BorderRadius.circular(26),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: [
                    widget.gradientStartColor ?? Color(0xff441DFC),
                    widget.gradientEndColor ?? Color(0xff4E81EB),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Container(
                height: 176,
                width: 305,
                child: Stack(
                  children: [
                    // vectorBottom ??
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(26),
                    //       child: Icon(Icons.security),
                    //     ),
                    // vectorTop ??
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(26),
                    //       child: Icon(Icons.security_update_good),
                    //     ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, top: 24, bottom: 24, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: widget.tag ?? '',
                                child: Material(
                                  color: Colors.transparent,
                                  child: AutoSizeText(
                                    widget.data.title,
                                    maxLines: widget.isRecommended ? 2 : 5,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(getCategoryNameById(widget.data.category).toUpperCase(), style: Theme.of(context).textTheme.caption,)
                            ],
                          ),
                          Row(
                            children: widget.data.tags.map((e) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Tooltip(message: getIt<DataRepository>().tags.firstWhere((element) => element.id == e).tag, child: Icon(tag2icon(e))),
                            )).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
