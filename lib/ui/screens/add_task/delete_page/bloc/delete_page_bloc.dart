import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'delete_page_event.dart';
part 'delete_page_state.dart';

class DeletePageBloc extends Bloc<DeletePageEvent, DeletePageState> {
  DeletePageBloc() : super(DeletePageInitialState()) {
    on<DeletePageGetDataEvent>(_getData);
    on<DeletePageDeleteEvent>(_delete);
  }

  Future<void> _getData(DeletePageGetDataEvent event, Emitter emit) async {
    emit(DeletePageInProgressState());
    final box = await Hive.openBox('pages');
    final List<PageModel> pages = [];
    pages.addAll(box.values.cast());
    emit(DeletePageGetDataState(pages));
  }

  Future<void> _delete(DeletePageDeleteEvent event, Emitter emit) async {
    emit(DeletePageInProgressState());
    final box = await Hive.openBox('pages');
    box.delete(box.keyAt(event.index));
    emit(DeletePageInitialState());
  }
}
