import 'package:flutter/material.dart';
import 'package:todolist_flutter/theme.dart';

class TitleDialog extends StatelessWidget {
  Function resetForm;
  TitleDialog({Key? key, required this.resetForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: white100Color,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tambah List Item',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: blackColor,
            ),
          ),
          GestureDetector(
            child: const Icon(
              Icons.close,
              size: 16,
            ),
            onTap: () => resetForm(),
          ),
        ],
      ),
    );
  }
}

showSnackbar(bool isAdd, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(isAdd ? 'Berhasil menambah data' : 'Berhasil edit data'),
    ),
  );
}
