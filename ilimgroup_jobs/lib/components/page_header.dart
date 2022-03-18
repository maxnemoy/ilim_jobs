import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class PageHeader extends StatelessWidget {
  final List<Widget>? actions;
  final String? title;
  final Widget? customLeading;
  const PageHeader({Key? key, this.actions, this.title, this.customLeading}) : super(key: key);

  final bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          customLeading ?? const _BackButton(),
          if(title != null) _PageTitle(title: title),
          const Spacer(),
          if(actions!= null) Row(
            children: actions!,
          )
        ],
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(title!);
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(360),
      onTap: () {
        Routemaster.of(context).pop();
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(360),
        ),
        child: const Center(
          child: Icon(Icons.chevron_left),
        ),
      ),
    );
  }
}
