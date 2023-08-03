import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  static Future<XFile?> getImageFromGallery() async {
    final status = await Permission.photos.request();

    if(status.isGranted) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return null;
      return image;
    }

    return null;
  }

  static Future<List<XFile>?> getMultiImagesFromGallery() async {
    final status = await Permission.photos.request();

    print(status);


    if(status.isGranted) {
      List<XFile> images = await ImagePicker().pickMultiImage();
      if(images.isEmpty) return null;
      return images;
    }

    return null;
  }

  static Future<XFile?> getImageFromCamera() async {
    final status = await Permission.camera.request();

    print(status);


    if(status.isGranted) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return null;
      return image;
    }

    return null;
  }

}