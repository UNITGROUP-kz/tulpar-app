import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/services/image_service.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImagePicker extends StatelessWidget {
  final Function(XFile?) callback;

  const ChooseImagePicker({super.key, required this.callback});


  _camera() async {
    XFile? image = await ImageService.getImageFromCamera();

    callback(image);
  }

  _gallery() async {
    XFile? image = await ImageService.getImageFromGallery();

    callback(image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tile(icon: Icons.camera_alt_outlined, text: 'Камера', callback: _camera),
          Divider(thickness: 1),
          Tile(icon: Icons.image_outlined, text: 'Галлерея', callback: _gallery),

        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback callback;

  const Tile({super.key, required this.icon, required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Expanded(child: Text(text))
          ],
        ),
      ),
    );
  }

}