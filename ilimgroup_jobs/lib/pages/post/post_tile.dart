import 'package:flutter/material.dart';
import 'package:ilimgroup_jobs/components/style_data.dart';
import 'package:ilimgroup_jobs/core/models/post/post_data.dart';

class PostTile extends StatefulWidget {
  final PostData data;
  const PostTile({Key? key, required this.data}) : super(key: key);

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
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
                print(v);
              });
            },
            //onTap: () => widget.onTap!(),
            borderRadius: BorderRadius.circular(26),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff441DFC),
                    Color(0xff4E81EB),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: SizedBox(
                height: 500,
                width: 400,
                child: Row(
                  children: [
                    if (widget.data.assets.isNotEmpty)
                      Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                            child: Image.network(
                                                  widget.data.assets[0],
                                                  fit: BoxFit.cover,
                                                ),
                          )),
                    if (widget.data.assets.isNotEmpty)
                    Container(height: double.infinity, width: 1, color: Colors.white,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.data.title, overflow: TextOverflow.fade, style: Theme.of(context).textTheme.titleMedium,),
                    ))
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
