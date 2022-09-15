import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_flutter/models/activity_model.dart';
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(const ActivityState([])) {
    on<TambahData>(
      (event, emit) => emit(ActivityState([event.data, ...state.activityHome])),
    );
    on<EditData>(
      (event, emit) => emit(ActivityState(state.activityHome
          .map((item) => item.id == event.data.id ? event.data : item)
          .toList())),
    );
    on<DeleteData>(
      (event, emit) => emit(ActivityState(
          state.activityHome.where((item) => item.id != event.id).toList())),
    );
  }
}
