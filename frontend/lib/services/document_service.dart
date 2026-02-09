
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DocumentService {
  static Future<void> downloadAndOpen(String storagePath) async {
    final ref = FirebaseStorage.instance.ref(storagePath);
    final url = await ref.getDownloadURL();

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${storagePath.split('/').last}';

    await Dio().download(url, filePath);
    await OpenFilex.open(filePath);
  }
}
