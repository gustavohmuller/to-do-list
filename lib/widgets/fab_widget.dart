import 'package:flutter/material.dart';

import '../screens/task_screen.dart';
import '../utils/colors.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: fab,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskScreen(
              task: null,
              titleController: null,
              descriptionController: null,
            ),
          ),
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
