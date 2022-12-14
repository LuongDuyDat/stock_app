import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

enum UploadPostStatus {initial, loading, success}


class UploadPostState extends Equatable {
  const UploadPostState({
    this.content = '',
    this.pickedImage,
    this.uploadPostStatus = UploadPostStatus.initial,
  });

  final String content;
  final XFile? pickedImage;
  final UploadPostStatus uploadPostStatus;

  UploadPostState copyWith({
    String Function()? content,
    XFile Function()? pickedImage,
    UploadPostStatus Function()? uploadPostStatus,
  }) {
    return UploadPostState(
      content: content != null ? content() : this.content,
      pickedImage: pickedImage != null ? pickedImage() : this.pickedImage,
      uploadPostStatus: uploadPostStatus != null ? uploadPostStatus() : this.uploadPostStatus,
    );

  }

  @override
  List<Object?> get props => [
    content,
    pickedImage,
    uploadPostStatus,
  ];
}