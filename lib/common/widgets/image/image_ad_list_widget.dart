import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/add_image_widget.dart';
import 'package:onlinebozor/common/widgets/image/added_image_widget.dart';

import '../../gen/localization/strings.dart';
import '../common/common_button.dart';

class ImageAdListWidget extends StatelessWidget {
  const ImageAdListWidget({
    super.key,
    required this.imagePaths,
    required this.maxCount,
    required this.onTakePhotoClicked,
    required this.onPickImageClicked,
    required this.onImageClicked,
    required this.onRemoveClicked,
  });

  final List<String> imagePaths;
  final int maxCount;
  final Function() onTakePhotoClicked;
  final Function() onPickImageClicked;
  final Function() onImageClicked;
  final Function(String imagePath) onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Strings.imageListTitle.w(500).s(16),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 96,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: imagePaths.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AddImageWidget(
                      index: index,
                      onAddClicked: () {
                        if (imagePaths.length < maxCount) {
                          _showPickerTypeBottomSheet(context);
                        } else {
                          _showMaxCountError(context);
                        }
                      });
                } else {
                  return AddedImageWidget(
                    index: index,
                    imagePath: imagePaths[index - 1],
                    onImageClicked: () {},
                    onRemoveClicked: (imagePath) {
                      onRemoveClicked(imagePath);
                    },
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 12);
              },
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Strings.imageListMainImage.w(400).s(12),
          )
        ],
      ),
    );
  }

  void _showPickerTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 32),
              Center(child: Strings.imageListAddTitle.s(22).w(600)),
              SizedBox(height: 32),
              InkWell(
                onTap: () => onPickImageClicked(),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Color(0XFFFBFAFF),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Color(0xFFDFE2E9),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Strings.imageListAddPickImage.s(16).c(Colors.black),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CommonButton(
                  color: Colors.blueAccent,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Strings.imageListAddPickImage.s(16).c(Colors.white),
                  ),
                  onPressed: () {
                    onPickImageClicked();

                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CommonButton(
                  color: Colors.red,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Strings.imageListAddTakePhoto.s(16).c(Colors.white),
                  ),
                  onPressed: () {
                    onTakePhotoClicked();

                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMaxCountError(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Strings.imageListMaxCountError(max_count: maxCount).s(14),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Strings.closeTitle.s(14),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
