import 'package:flutter/material.dart';

showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text('msg')));
}

showSingleInputTextDialog({
  required BuildContext context,
  required String title,
  String posBtnText = 'SAVE',
  String negBtnText = 'CANCEL',
  required Function(String) onSave,
}) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          autofocus: false,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(negBtnText)),
        TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              Navigator.pop(context);
              onSave(controller.text);
            },
            child: Text(posBtnText))
      ],
    ),
  );
}
