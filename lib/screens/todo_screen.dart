import 'package:flutter/material.dart';
import 'package:todolist_flutter/bloc/activity/activit_bloc.dart';
import 'package:todolist_flutter/bloc/todo/todo_bloc.dart';
import 'package:todolist_flutter/data.dart';
import 'package:todolist_flutter/models/activity_model.dart';
import 'package:todolist_flutter/models/todo_model.dart';
import 'package:todolist_flutter/theme.dart';
import 'package:todolist_flutter/widgets/button.dart';
import 'package:todolist_flutter/widgets/card_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:todolist_flutter/widgets/dialog.dart';
import 'package:todolist_flutter/widgets/form.dart';

enum Menu { terbaru, terlama, az, za, belumSelesai }

// ignore: must_be_immutable
class TodoScreen extends StatefulWidget {
  static const String routeName = '/todo';
  late ActivityModel? data;
  TodoScreen({Key? key, this.data}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isChecked = false;
  Color? propertyValue;
  TodoModel? dataEdit;
  TextEditingController titleControl = TextEditingController(text: null);
  TextEditingController listItemControl = TextEditingController(text: null);

  @override
  void initState() {
    if (widget.data != null) {
      titleControl.text = widget.data!.title;
    }
    super.initState();
  }

  @override
  void dispose() {
    listItemControl.dispose();
    titleControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onSubmitTitleActivity() {
      var bloc = context.read<ActivityBloc>();
      ActivityModel data;
      if (widget.data != null) {
        data = ActivityModel(
          id: widget.data!.id,
          title: titleControl.text,
          tanggal: widget.data!.tanggal,
        );
        bloc.add(EditData(data));
        showSnackbar(false, context);
      } else {
        List<ActivityModel> activityState = bloc.state.activityHome;
        int maxid = activityState.isEmpty
            ? 0
            : activityState.map((e) => e.id).reduce(max);
        data = ActivityModel(
          id: maxid + 1,
          title: titleControl.text,
          tanggal: DateTime.now(),
        );
        bloc.add(TambahData(data));
        setState(() {
          widget.data = data;
        });
        showSnackbar(true, context);
      }
    }

    resetFormTodo() {
      setState(() {
        propertyValue = null;
      });
      listItemControl.text = '';
      if (dataEdit == null) {
        Navigator.pop(context);
      }
    }

    updateTodo(TodoModel item, bool done) {
      context.read<TodoBloc>().add(
            EditDataTodo(
              TodoModel(
                color: item.color,
                id: item.id,
                title: item.title,
                tanggal: item.tanggal,
                idActivity: item.idActivity,
                done: done,
              ),
            ),
          );
    }

    submitTodo() {
      var bloc = context.read<TodoBloc>();
      if (dataEdit != null) {
        TodoModel item = dataEdit!;
        updateTodo(
          TodoModel(
            id: item.id,
            title: listItemControl.text,
            tanggal: item.tanggal,
            idActivity: item.idActivity,
            color: propertyValue!,
          ),
          item.done,
        );
        resetFormTodo();
        setState(() {
          dataEdit = null;
        });
      } else {
        List<TodoModel> activityState = bloc.state.todo;
        int maxid = activityState.isEmpty
            ? 0
            : activityState.map((e) => e.id).reduce(max);

        bloc.add(
          TambahDataTodo(
            TodoModel(
              color: propertyValue!,
              id: maxid + 1,
              idActivity: widget.data!.id,
              title: listItemControl.text,
              tanggal: DateTime.now(),
              done: false,
            ),
          ),
        );
      }
      resetFormTodo();
    }

    Widget empty() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/todo-empty-state.png",
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            "Buat List Item Kamu",
            style: TextStyle(
              color: secondary100Color,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    }

    Future showFormTodo() {
      return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
              scrollable: true,
              title: TitleDialog(
                resetForm: () => resetFormTodo(),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    listItemForm(controller: listItemControl),
                    const SizedBox(
                      height: 30,
                    ),
                    priorityForm(
                      value: propertyValue,
                      onChanged: (Color? newValue) {
                        setState(() {
                          propertyValue = newValue!;
                        });
                      },
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                buttonPill(
                  () => submitTodo(),
                  icon: false,
                  label: "Simpan",
                )
              ],
            );
          },
        ),
      );
    }

    Widget header() {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: secondary200Color,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: titleControl,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: blackColor,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "New Activity",
                ),
              ),
            ),
            GestureDetector(
              onTap: onSubmitTitleActivity,
              child: Icon(
                Icons.edit_outlined,
                color: secondary100Color,
              ),
            ),
          ],
        ),
      );
    }

    Widget filterAndAddButton() {
      return BlocBuilder<TodoBloc, TodoState>(
        builder: (context, stateTodo) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<Menu>(
                enabled: stateTodo.todo.isNotEmpty,
                icon: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1) // changes position of shadow
                          ),
                    ],
                  ),
                  child: Icon(
                    Icons.refresh,
                    size: 30,
                    color: secondary100Color,
                  ),
                ),
                // Callback that sets the selected popup menu item.
                onSelected: (Menu item) {},
                itemBuilder: (BuildContext context) => dataSort
                    .map(
                      (e) => PopupMenuItem<Menu>(
                        value: Menu.terbaru,
                        child: Row(
                          children: [
                            e['icon'],
                            const SizedBox(
                              width: 10,
                            ),
                            Text(e['label']),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                width: 10,
              ),
              buttonPill(
                () {
                  showFormTodo();
                },
                disabled: widget.data == null,
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Activity"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            header(),
            const SizedBox(
              height: 20,
            ),
            filterAndAddButton(),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (ctx, state) {
                  return state.todo
                          .where((item) => item.idActivity == widget.data?.id)
                          .isEmpty
                      ? empty()
                      : ListView(
                          children: state.todo
                              .where((element) =>
                                  element.idActivity == widget.data!.id)
                              .map(
                                (item) => CardTodo(
                                  setState: (bool done) =>
                                      updateTodo(item, done),
                                  data: item,
                                  update: () {
                                    setState(() {
                                      dataEdit = item;
                                      propertyValue = item.color;
                                      listItemControl.text = item.title;
                                    });
                                    showFormTodo();
                                  },
                                ),
                              )
                              .toList(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
