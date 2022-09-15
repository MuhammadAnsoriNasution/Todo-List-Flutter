part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TambahDataTodo extends TodoEvent {
  final TodoModel data;
  const TambahDataTodo(this.data);
}

class EditDataTodo extends TodoEvent {
  final TodoModel data;
  const EditDataTodo(this.data);
}

class DeleteDataTodo extends TodoEvent {
  final int id;
  const DeleteDataTodo(this.id);
}
