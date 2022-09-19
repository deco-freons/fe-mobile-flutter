import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/components/buttons/circle_icon_button.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/common/utils/file_parser.dart';
import 'package:image_picker/image_picker.dart';

const kilobyte = 1024;

class ImageInput extends StatefulWidget {
  final CustomFormInput customFormInput;
  final double height;
  final double width;
  final double radius;
  final Icon icon;
  const ImageInput(
      {Key? key,
      required this.customFormInput,
      this.height = 200,
      this.width = double.infinity,
      this.radius = CustomRadius.lg,
      required this.icon})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: primary.shade300,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius)),
        elevation: 0,
        child: InkWell(
          splashColor: primary.shade400.withOpacity(0.5),
          highlightColor: primary.shade400.withOpacity(0.2),
          onTap: () {
            pickImage(context);
          },
          child: widget.customFormInput.image != null ||
                  widget.customFormInput.initialImage != null
              ? Stack(children: [
                  Ink(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.radius),
                      image: DecorationImage(
                        image: widget.customFormInput.image != null
                            ? FileImage(widget.customFormInput.image!)
                            : NetworkImage(widget.customFormInput.initialImage!)
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      right: CustomPadding.sm,
                      top: CustomPadding.sm,
                      child: CircleIconButton(
                        radius: CustomRadius.xl,
                        iconSize: 24,
                        icon: const Icon(Icons.close),
                        iconColor: neutral.shade100,
                        bgColor: error,
                        onPressed: () {
                          setState(() {
                            widget.customFormInput.setImage(null);
                          });
                        },
                      ))
                ])
              : SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: widget.icon),
        ),
      ),
    );
  }

  void pickImage(BuildContext context) async {
    ScaffoldMessengerState scaffoldState = ScaffoldMessenger.of(context);
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (selectedImage != null) {
      String errorMessage = "";

      if (await getFileSize(selectedImage) > 3.0) {
        errorMessage = "Image must not exceed 3MB";
      } else if (!FileParser.isValidImage(selectedImage.path)) {
        errorMessage = "File type must be jpeg, jpg, png";
      }
      if (errorMessage.isEmpty) {
        setState(() {
          widget.customFormInput.setImage(File(selectedImage.path));
        });
      } else {
        scaffoldState.showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  Future<double> getFileSize(XFile file) async {
    return (await file.length()) / (kilobyte * kilobyte);
  }
}
