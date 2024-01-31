import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:work/helper/app_constant.dart';

import '../../Provider/signupController.dart';

class FileUploadVehicleWidget extends StatefulWidget {
  final String text;
  final  controller;
  const FileUploadVehicleWidget({super.key, required this.text, required this.controller});

  @override
  State<StatefulWidget> createState() => _FileUploadVehicleWidgetState();
}

class _FileUploadVehicleWidgetState extends State<FileUploadVehicleWidget> {

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        widget.controller.selectedFileVehicle = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickFile,
          child: DottedBorder(
            color: appPrimaryColor,
            strokeWidth: 1,
            dashPattern: const [5, 5],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: SizedBox(
              width: 120,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    color: appPrimaryColor,
                  ),
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600, color: appPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.controller.selectedFileVehicle != null)
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selected File:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                    'File Name: ${widget.controller.selectedFileVehicle!.path.split('/').last}'),
                const SizedBox(height: 8),
                Text(
                    'File Size: ${(widget.controller.selectedFileVehicle!.lengthSync() / 1024).toStringAsFixed(2)} KB'),
              ],
            ),
          ),
      ],
    );
  }
}
