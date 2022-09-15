part of 'activit_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class TambahData extends ActivityEvent {
  final ActivityModel data;
  const TambahData(this.data);
}

class EditData extends ActivityEvent {
  final ActivityModel data;
  const EditData(this.data);
}

class DeleteData extends ActivityEvent {
  final int id;
  const DeleteData(this.id);
}
