import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/bloc/activity/activit_bloc.dart';
import 'package:todolist_flutter/models/activity_model.dart';
import 'package:todolist_flutter/screens/todo_screen.dart';
import 'package:todolist_flutter/theme.dart';
import 'package:todolist_flutter/widgets/button.dart';
import 'package:todolist_flutter/widgets/card_activity.dart';
import 'package:todolist_flutter/widgets/swall_confirmation.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = '/activity';

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    Widget empty() {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/activity-empty-state.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Buat activity pertamamu",
              style: TextStyle(
                color: secondary100Color,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      );
    }

    Widget content(activityHome) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          itemCount: activityHome.length,
          itemBuilder: (context, index) {
            return CardActivity(data: activityHome[index]);
          },
        ),
      );
    }

    Widget header() {
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Activity",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            buttonPill(
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoScreen(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List App"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 28,
        ),
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            return Column(
              children: [
                header(),
                state.activityHome.isEmpty
                    ? empty()
                    : content(state.activityHome)
              ],
            );
          },
        ),
      ),
    );
  }
}
