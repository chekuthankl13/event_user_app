
import 'package:event_user/core/usecase/usecase.dart';
import 'package:event_user/features/event/domain/entity/event_entity.dart';
import 'package:event_user/features/event/domain/usecase/load_event_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_state.dart';
part 'event_cubit.freezed.dart';

class EventCubit extends Cubit<EventState> {
  final LoadEventUsecase loadEventUsecase;

  EventCubit(this.loadEventUsecase) : super(EventState.initial());

load() async {
    try {
      emit(EventState.loading());
      var res = await loadEventUsecase(NoParam());
      res.fold(
        (l) => emit(EventState.error(error: l.error)),
        (r) => emit(EventState.loaded(events: r)),
      );
    } catch (e) {
      emit(EventState.error(error: e.toString()));
    }
  }
}
