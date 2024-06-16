import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todolist/main.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/empty_state.svg',
          width: 120,
        ),
        const SizedBox(height: 12),
        const Text('Youe Task List Is Empty')
      ],
    );
  }
}

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({super.key, required this.value, required this.onTap});
  final bool value;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                !value ? Border.all(color: secondryTextColor, width: 2) : null,
            color: value ? primaryColor : null),
        child: value
            ? Icon(
                size: 16,
                CupertinoIcons.check_mark,
                color: themeData.colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }
}
