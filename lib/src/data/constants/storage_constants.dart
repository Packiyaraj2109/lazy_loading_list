import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageConst {
  static final StorageConst _storageConst = StorageConst._();

  factory StorageConst() => _storageConst;

  FlutterSecureStorage _storage;

  StorageConst._() {
    init();
  }

  void init() {
    _storage = const FlutterSecureStorage();
  }

  storageread(String listname) async {
    dynamic fetchedData = await _storage.read(key: listname);
    return fetchedData;
  }

  Future<void> storagewrite(String listname, List data) async {
    await _storage.write(key: listname, value: json.encode(data));
  }

  Future<void> storagedelete(String listname) async {
    await _storage.delete(key: listname);
  }
}