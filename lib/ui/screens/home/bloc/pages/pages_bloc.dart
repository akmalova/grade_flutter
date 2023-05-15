import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade/domain/model/page_model.dart';
import 'package:grade/domain/model/page_types.dart';
import 'package:grade/domain/repository/page_repository.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  final PageRepository pageRepository;

  PagesBloc(this.pageRepository) : super(PagesInitialState()) {
    on<PagesGetDataEvent>(_getData);
    on<PagesSaveEvent>(_save);
    on<PagesTypeChangedEvent>(_typeChanged);
    on<PagesNameChangedEvent>(_nameChanged);
    on<PagesFunctionNameChangedEvent>(_functionNameChanged);
    on<PagesParametersTitlesChangedEvent>(_parametersTitlesChanged);
    on<PagesParametersChangedEvent>(_parametersChanged);
    on<PagesParameterAddedEvent>(_parameterAdded);
    on<PagesParameterDeletedEvent>(_parameterDeleted);
    on<PagesDeleteEvent>(_delete);
    on<PagesOpenSaveInitialEvent>(_openInitial);
  }

  Future<void> _getData(PagesGetDataEvent event, Emitter emit) async {
    emit(PagesGetDataInProgressState());
    final List<PageModel> pages = await pageRepository.fetchPages();
    List<PageModel> studentsPages = [];
    List<PageModel> teachersPages = [];
    List<PageModel> disciplinesPages = [];
    for (PageModel page in pages) {
      switch (page.type) {
        case PageTypes.students:
          studentsPages.add(page);
          break;
        case PageTypes.teachers:
          teachersPages.add(page);
          break;
        case PageTypes.disciplines:
          disciplinesPages.add(page);
          break;
        default:
      }
    }
    emit(
      PagesGetDataSuccessState(
        pages: pages,
        studentsPages: studentsPages,
        teachersPages: teachersPages,
        disciplinesPages: disciplinesPages,
      ),
    );
  }

  Future<void> _save(PagesSaveEvent event, Emitter emit) async {
    final previuosState = state as PagesSaveInitialState;
    emit(PagesSaveInProgressState());
    if (previuosState.page.pageName.isEmpty ||
        previuosState.page.functionName.isEmpty) {
      emit(PagesSaveInitialState(
        isEmptyFields: true,
        page: previuosState.page,
      ));
    } else {
      pageRepository.savePage(previuosState.page);
      emit(PagesSaveSuccessState());
    }
  }

  void _typeChanged(PagesTypeChangedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    emit(
      PagesSaveInitialState(
        page: PageModel(
          type: event.pageType,
          pageName: previuosState.page.pageName,
          functionName: previuosState.page.functionName,
          parameters: previuosState.page.parameters,
          parametersTitles: previuosState.page.parametersTitles,
        ),
      ),
    );
  }

  void _nameChanged(PagesNameChangedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    emit(
      PagesSaveInitialState(
        page: PageModel(
          type: previuosState.page.type,
          pageName: event.pageName,
          functionName: previuosState.page.functionName,
          parameters: previuosState.page.parameters,
          parametersTitles: previuosState.page.parametersTitles,
        ),
      ),
    );
  }

  void _functionNameChanged(PagesFunctionNameChangedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    emit(
      PagesSaveInitialState(
        page: PageModel(
          type: previuosState.page.type,
          pageName: previuosState.page.pageName,
          functionName: event.functionName,
          parameters: previuosState.page.parameters,
          parametersTitles: previuosState.page.parametersTitles,
        ),
      ),
    );
  }

  void _parametersTitlesChanged(
      PagesParametersTitlesChangedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    previuosState.page.parametersTitles[event.index] = event.parameterTitle;
    emit(
      PagesSaveInitialState(page: previuosState.page),
    );
  }

  void _parametersChanged(PagesParametersChangedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    previuosState.page.parameters[event.index] = event.parameter;
    emit(
      PagesSaveInitialState(page: previuosState.page),
    );
  }

  void _parameterAdded(PagesParameterAddedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    previuosState.page.parameters.add('');
    previuosState.page.parametersTitles.add('');
    emit(
      PagesSaveInitialState(page: previuosState.page),
    );
  }

  void _parameterDeleted(PagesParameterDeletedEvent event, Emitter emit) {
    final previuosState = state as PagesSaveInitialState;
    previuosState.page.parameters.removeLast();
    previuosState.page.parametersTitles.removeLast();
    emit(
      PagesSaveInitialState(page: previuosState.page),
    );
  }

  Future<void> _delete(PagesDeleteEvent event, Emitter emit) async {
    emit(PagesDeleteInProgressState());
    pageRepository.deletePage(event.index);
    emit(PagesDeleteSuccessState());
  }

  Future<void> _openInitial(
      PagesOpenSaveInitialEvent event, Emitter emit) async {
    emit(
      PagesSaveInitialState(
        page: PageModel(
          type: PageTypes.students,
          pageName: '',
          functionName: '',
          parameters: [''],
          parametersTitles: [''],
        ),
      ),
    );
  }
}
