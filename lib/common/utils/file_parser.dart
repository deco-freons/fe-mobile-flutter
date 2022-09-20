import 'package:mime/mime.dart';

const validImages = ["jpg", "jpeg", "png"];

class FileParser {
  static List<String>? getFileMime(String path) {
    String? mime = lookupMimeType(path, headerBytes: [0xFF, 0xD8]);
    if (mime == null) return null;

    return mime.split("/");
  }

  static bool isValidImage(String path) {
    List<String>? mime = getFileMime(path);
    if (mime == null) return false;
    if (mime.length < 2) return false;
    return validImages.contains(mime[1]);
  }
}
