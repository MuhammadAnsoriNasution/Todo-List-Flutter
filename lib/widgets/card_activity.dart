import 'package:flutter/material.dart';
import 'package:todolist_flutter/bloc/activity/activit_bloc.dart';
import 'package:todolist_flutter/models/activity_model.dart';
import 'package:todolist_flutter/theme.dart';
import 'package:todolist_flutter/widgets/swall_confirmation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardActivity extends StatelessWidget {
  ActivityModel data;
  CardActivity({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    confirmation() {
      var bloc = context.read<ActivityBloc>();
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SwallConfirmation(
            onConfirm: () => bloc.add(
              DeleteData(data.id),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, '/todo', arguments: data);
      }),
      child: Container(
        padding: const EdgeInsets.only(
          top: 13,
          bottom: 17,
          left: 17,
          right: 17,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: blackColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data.tanggal.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () => confirmation(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
