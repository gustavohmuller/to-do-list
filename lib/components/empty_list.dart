import 'package:flutter/material.dart';

import '../utils/strings.dart';
import '../utils/theme.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: Image.asset(
              "assets/images/no_tasks.png",
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            noTasks,
            style: Style.textStyle7,
          ),
        ],
      );
  }
}