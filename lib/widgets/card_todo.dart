import 'package:flutter/material.dart';
import 'package:todolist_flutter/bloc/todo/todo_bloc.dart';
import 'package:todolist_flutter/models/todo_model.dart';
import 'package:todolist_flutter/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Color getColor(Set<MaterialState> states) {
  return greenColor;
}

class CardTodo extends StatelessWidget {
  Function setState;
  TodoModel data;
  Function update;

  CardTodo({
    Key? key,
    required this.setState,
    required this.data,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deleteTodo() {
      context.read<TodoBloc>().add(
            DeleteDataTodo(data.id),
          );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(
        right: 10,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: data.done,
                  onChanged: (bool? value) => setState(value),
                ),
                const SizedBox(
                  width: 1,
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: data.color,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: blackColor,
                    decoration: data.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontStyle: data.done ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 14,
                  ),
                  onTap: () => update(),
                )
              ],
            ),
          ),
          GestureDetector(
            child: const Icon(Icons.delete),
            onTap: () => deleteTodo(),
          ),
        ],
      ),
    );
  }
}
