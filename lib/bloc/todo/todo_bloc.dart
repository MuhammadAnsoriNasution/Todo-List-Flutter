import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([])) {
    on<TambahDataTodo>(
      (event, emit) => emit(TodoState([event.data, ...state.todo])),
    );
    on<EditDataTodo>(
      (event, emit) => emit(TodoState(state.todo
          .map((item) => item.id == event.data.id ? event.data : item)
          .toList())),
    );
    on<DeleteDataTodo>(
      (event, emit) => emit(
          TodoState(state.todo.where((item) => item.id != event.id).toList())),
    );
  }
}
