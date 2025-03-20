import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx/core/constants/app_enums.dart';

abstract class DashboardEvent {}

class ChangeTab extends DashboardEvent {
  final DashboardTab tab;
  ChangeTab(this.tab);
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardTab> {
  DashboardBloc() : super(DashboardTab.home) {
    on<ChangeTab>((event, emit) => emit(event.tab));
  }
}
