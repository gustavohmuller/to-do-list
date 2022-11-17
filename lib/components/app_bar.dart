import 'package:flutter/material.dart';

import '../utils/theme.dart';

class AppBar extends StatelessWidget with PreferredSizeWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0XFF2E3440),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0,
            padding: const EdgeInsets.only(right: 12.0),
          ),
          child: Row(
            children: const [
              Icon(
                color: Colors.white,
                size: 40,
                Icons.keyboard_arrow_left_rounded,
              ),
              Text(
                'Go back',
                style: Style.textStyle11,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}