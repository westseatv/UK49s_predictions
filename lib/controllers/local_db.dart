import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/saved.dart';

const savedNumbersBox = 'saved_numbers';
const lastIndexBox = 'last_index';
const lastIndexKey = 'last_index_key';

class LocalDb extends GetxController {
  final GetStorage _lastIndexBox = GetStorage(lastIndexBox);
  final GetStorage savedBox = GetStorage(savedNumbersBox);

  void initLocalDb() async {
    await _lastIndexBox.initStorage;
    await savedBox.initStorage;

    if (_lastIndexBox.read(lastIndexKey) == null) {
      try {
        await _lastIndexBox.write(lastIndexKey, -1);
        await _lastIndexBox.save();
      } catch (e) {
        Get.log(e.toString());
      }
    }
  }

  void saveNumbers(Saved saved) async {
    int key = await _lastIndexBox.read(lastIndexKey);
    key += 1;
    Map<String, dynamic> value = saved.toMap();

    await _lastIndexBox.write(lastIndexKey, key);
    await _lastIndexBox.save();
    await savedBox.write(key.toString(), value);
    await savedBox.save();
  }

  List<Saved> readSavedNumbers() {
    int lastIndex = _lastIndexBox.read(lastIndexKey);
    List<Saved> saved = [];
    if (lastIndex > -1) {
      for (var i = 0; i <= lastIndex; i++) {
        Map<String, dynamic> value =
            savedBox.read(i.toString()) as Map<String, dynamic>;
        saved.add(Saved.fromMap(value));
      }
    }
    return saved;
  }

  void clearAll() {
    _lastIndexBox.write(lastIndexKey, -1);
    savedBox.erase();
    _lastIndexBox.save();
    _lastIndexBox.save();
  }

  @override
  void onInit() {
    initLocalDb();
    super.onInit();
  }
}
