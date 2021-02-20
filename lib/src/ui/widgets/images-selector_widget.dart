import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';

class ImageSelector extends StatefulWidget {
  final File image;
  final Function(File file) onChanged;

  ImageSelector({
    this.image,
    @required this.onChanged,
  }) : assert(onChanged != null);

  @override
  createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File image;
  final _picker = ImagePicker();
  AppLocalizations lang;

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    lang = AppLocalizations.of(context);
    Widget child;

    if (image == null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(CupertinoIcons.photo),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
          ),
          Text(
            lang.noImage,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    } else {
      child = GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(lang.deleteImage),
              actions: [
                FlatButton(
                  onPressed: () {
                    image = null;
                    widget.onChanged(image);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: Text(lang.yes),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(lang.no),
                ),
              ],
            ),
          );
        },
        child: Image.file(
          image,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 150.0,
          color: Colors.grey.shade200,
          child: Center(child: child),
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.orange,
              child: IconButton(
                icon: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
                onPressed: _imgFromGallery,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(CupertinoIcons.photo_camera),
                  onPressed: _imgFromCamera,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _imgFromCamera() async {
    final pickedImage =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null)
      setState(() {
        image = File(pickedImage.path);
        widget.onChanged(image);
      });
  }

  _imgFromGallery() async {
    final pickedImage =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null)
      setState(() {
        image = File(pickedImage.path);
        widget.onChanged(image);
      });
  }
}
