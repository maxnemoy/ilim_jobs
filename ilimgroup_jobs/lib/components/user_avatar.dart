import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? url;
  final bool whitBorder;
  const UserAvatar({Key? key, this.url, this.whitBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: BorderSide(
                width:whitBorder ? 5 :0 , color: Theme.of(context).colorScheme.background)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(42),
            child: GestureDetector(
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: url?.isEmpty ?? true
                      ? const Icon(
                          Icons.account_circle,
                          size: 100,
                        )
                      : Image.network(
                          url!,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        )),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
