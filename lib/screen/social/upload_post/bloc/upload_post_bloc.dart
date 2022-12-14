import 'package:bloc/bloc.dart';
import 'package:stock_app/repositories/social_repository/post_hive_repository.dart';
import 'package:stock_app/screen/social/upload_post/bloc/upload_post_event.dart';
import 'package:stock_app/screen/social/upload_post/bloc/upload_post_state.dart';
import 'package:stock_app/util/globals.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostBloc({
    required PostHiveRepository postHiveRepository,
  }) : _postHiveRepository = postHiveRepository,
        super(const UploadPostState()) {
    on<UploadPostContentChange>(_onContentChange);
    on<UploadPostImageChange>(_onImageChange);
    on<UploadPostSubmit>(_onSubmit);
  }

  final PostHiveRepository _postHiveRepository;

  void _onContentChange(
      UploadPostContentChange event,
      Emitter<UploadPostState> emit,
      ) {
    emit(state.copyWith(
      content: () => event.content,
    ));
  }

  void _onImageChange(
      UploadPostImageChange event,
      Emitter<UploadPostState> emit,
      ) {
    emit(state.copyWith(
      pickedImage: () => event.file,
    ));
  }

  Future<void> _onSubmit (
      UploadPostSubmit event,
      Emitter<UploadPostState> emit,
      ) async{
    emit(state.copyWith(
      uploadPostStatus: () => UploadPostStatus.loading,
    ));
    await _postHiveRepository.createPost(
      account.name,
      state.content,
      state.pickedImage,
      event.symbol,
    );
    emit(state.copyWith(
      uploadPostStatus: () => UploadPostStatus.success,
    ));
  }
}