part of 'activit_bloc.dart';

class ActivityState extends Equatable {
  final List<ActivityModel> activityHome;

  const ActivityState(this.activityHome);

  @override
  List<Object> get props => [activityHome];
}
