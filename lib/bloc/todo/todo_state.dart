part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<TodoModel> todo;

  const TodoState(this.todo);

  @override
  List<Object> get props => [todo];
}
