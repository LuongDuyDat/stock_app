import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object?> get props => [];
}

class UploadPostContentChange extends UploadPostEvent {
  const UploadPostContentChange({
    required this.content,
  });

  final String content;

  @override
  List<Object?> get props => [content];
}

class UploadPostImageChange extends UploadPostEvent {
  const UploadPostImageChange({
    required this.file,
  });

  final XFile file;

  @override
  List<Object?> get props => [file];
}

class UploadPostSubmit extends UploadPostEvent {
  const UploadPostSubmit({required this.symbol,});

  final String symbol;

  @override
  List<Object?> get props => [symbol];
}