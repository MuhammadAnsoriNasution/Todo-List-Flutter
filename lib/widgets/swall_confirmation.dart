import 'package:flutter/material.dart';

class SwallConfirmation extends StatelessWidget {
  Function onConfirm;
  SwallConfirmation({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
