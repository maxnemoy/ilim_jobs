import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/style_data.dart';

class VacancyCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
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
      this.title,
      this.subtitle,
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
      padding: EdgeInsets.symmetric(vertical: isHover? 0: 5),
      child: DecoratedBox(
        decoration: isHover ? StyleData.iconBoxDecoration(context) : const BoxDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onHover: (v){
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
                      padding: EdgeInsets.only(left: 24, top: 24, bottom: 24, right: 5),
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
                                    widget.title!,
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
                              widget.subtitle != null
                                  ? Text(
                                      widget.subtitle!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    )
                                  : Container(),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.select_all_rounded),
                              SizedBox(width: 24),
                              Icon(Icons.sell)
                            ],
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