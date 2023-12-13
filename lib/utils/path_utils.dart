import 'package:path/path.dart' as p;

class PathUtils {
  getNameByPath(String path) {
    return p.basenameWithoutExtension(path).substring(9);
  }

  getId(String path) {
    return p.basenameWithoutExtension(path).substring(0, 8);
  }

}