import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/add_image_widget.dart';
import 'package:onlinebozor/common/widgets/image/added_image_widget.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';

import '../../gen/assets/assets.gen.dart';
import '../../gen/localization/strings.dart';
import '../../vibrator/vibrator_extension.dart';
import '../bottom_sheet/bottom_sheet_title.dart';

class ImageAdListWidget extends StatelessWidget {
  const ImageAdListWidget({
    super.key,
    required this.imagePaths,
    required this.maxCount,
    required this.onTakePhotoClicked,
    required this.onPickImageClicked,
    required this.onImageClicked,
    required this.onRemoveClicked,
    required this.onReorder,
  });

  final List<UploadableFile> imagePaths;
  final int maxCount;
  final Function() onTakePhotoClicked;
  final Function() onPickImageClicked;
  final Function(int index) onImageClicked;
  final Function(String imagePath) onRemoveClicked;
  final Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      margin: EdgeInsets.only(top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Strings.imageListTitle.w(500).s(14),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 82,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  AddImageWidget(
                    key: ValueKey(-1),
                    index: -1,
                    onAddClicked: () {
                      if (imagePaths.length < maxCount) {
                        _showPickerTypeBottomSheet(context);
                      } else {
                        _showMaxCountError(context);
                      }
                    },
                  ),
                  ReorderableListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 6, right: 10),
                    proxyDecorator: (
                      Widget child,
                      int index,
                      Animation<double> animation,
                    ) {
                      return Material(
                        elevation: 0,
                        animationDuration: Duration.zero,
                        color: Colors.transparent,
                        child: child,
                      );
                    },
                    onReorderStart: (index) {
                      vibrateAsHapticFeedback();
                    },
                    onReorder: (int oldIndex, int newIndex) {
                      onReorder(oldIndex, newIndex);
                      vibrateAsHapticFeedback();
                    },
                    children: imagePaths
                        .mapIndexed(
                          (index, element) => Padding(
                            key: ValueKey(element),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: AddedImageWidget(
                              key: ValueKey(element),
                              index: index,
                              imagePath: element.xFile.path,
                              onImageClicked: () {
                                onImageClicked(index);
                              },
                              onRemoveClicked: (imagePath) {
                                onRemoveClicked(element.xFile.path);
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Strings.imageListMainImage.w(400).s(10),
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
              SizedBox(height: 20),
              BottomSheetTitle(
                title: Strings.actionTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  onTakePhotoClicked();
                  Navigator.pop(context);
                  vibrateAsHapticFeedback();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Assets.images.icAddImageCamera.svg(),
                      SizedBox(width: 24),
                      Strings.imageListAddTakePhoto.s(16).w(400),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              InkWell(
                onTap: () {
                  onPickImageClicked();
                  Navigator.pop(context);
                  vibrateAsHapticFeedback();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Assets.images.icAddImageGallery.svg(),
                      SizedBox(width: 24),
                      Strings.imageListAddPickImage.s(16).w(400),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
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
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
