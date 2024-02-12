import 'package:image_picker/image_picker.dart';

Future<XFile?> getImage({
  required ImagePicker picker,
  required ImageSource src,
}) async {
  final XFile? pickedFile = await picker.pickImage(
    source: src,
    // TODO: quality 설정
    // imageQuality: quality,
  );

  return pickedFile;
}
