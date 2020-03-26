import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DoctorGallery extends StatefulWidget {
  @override
  _DoctorGalleryState createState() => _DoctorGalleryState();
}

class _DoctorGalleryState extends State<DoctorGallery> {
  File _image1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future imageSelectorGallery1() async {
      var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );

      setState(() {
        _image1 = image;
      });
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth / 2 - 10;
    return Stack(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 10.0, top: 5.0, right: 5, bottom: 20),
          child: Card(
            elevation: 2.0,
            color: Colors.cyanAccent,
            child: Material(
              child: InkWell(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: cardWidth,
                        height: 150,
                        color: Colors.blue,
                        child: _image1 == null
                            ? Image.asset('assets/img/user.png')
                            : Image.file(_image1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

typedef void RatingChangeCallback(double rating);
