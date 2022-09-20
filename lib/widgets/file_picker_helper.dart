// ignore_for_file: prefer_collection_literals

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

FutureOr<FilePickerResult?> getFilePicker() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  try {
    return Future.value(result);
  } catch (e) {
    throw Future.error(e);
  }
}

FutureOr<FilePickerResult?> getMultipleFilePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
  try {
    return Future.value(result);
  } catch (e) {
    throw Future.error(e);
  }
}

Future<List<dynamic>> pickPicture({
  //required bool isGallery,
  required BuildContext context,
}) async {
  try {
    final picker = ImagePicker();
    final imagePicker = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imagePicker == null) {
      throw 'Image is not selected!!';
    }
    File image = File(imagePicker.path);
    final a = await imagePicker.readAsBytes();

    print('ye rhi image');
    print(image);
    print('aaaaaaa${imagePicker.path}');
    Uint8List compressedImage = await compressFile(image);

    String filename = image.path.split('/').last;
    print('eerrr$filename');

    // });
    return [image, filename];
  } catch (error) {
    return [];
    // showErrorDialogue(error.toString(), context);

  }
}

// * compress file **
Future<Uint8List> compressFile(File file) async {
  var result;
  try {
    result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 50,
    );
  } on UnsupportedError catch (_) {
    result = file.readAsBytesSync();
  }
  return result;
}
