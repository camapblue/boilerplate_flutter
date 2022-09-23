import 'dart:convert';
import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:repository/model/model.dart';

class TestData<T extends Entity> {
  final Mapper<T> _mapper;

  TestData({required Mapper<T> mapper}) : _mapper = mapper;

  Future<List<T>> getListItems(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dataJson = List<Map<String, dynamic>>.from(json.decode(data));
      return _mapper.toList(json: dataJson);
    } catch (e) {
      log.error('Cannot parse json file: $path for error: $e');
      return [];
    }
  }

  Future<T?> getItem(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dataJson = json.decode(data);
      return _mapper.toObject(json: dataJson);
    } catch (e) {
      log.error('Cannot parse json file: $path for error: $e');
      return null;
    }
  }

  static Future<List<User>> getListUsers() async {
    final testData =
        TestData<User>(mapper: Mapper<User>(parser: User.fromJson));

    return testData.getListItems('test_data/list_user.json');
  }
}
