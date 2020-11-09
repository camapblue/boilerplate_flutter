import 'dart:convert';
import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:repository/model/model.dart';

class TestData<T extends Entity> {
  final Mapper<T> _mapper;

  TestData({Mapper<T> mapper}) : _mapper = mapper;

  Future<List<T>> getListItems(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dataJson = List<Map<String, dynamic>>.from(json.decode(data));
      return dataJson.map(_mapper.parse).toList();
    } catch (e) {
      log.error('Cannot parse json file: $path for error: $e');
      return [];
    }
  }

  Future<T> getItem(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final dataJson = json.decode(data);
      return _mapper.parse(dataJson);
    } catch (e) {
      log.error('Cannot parse json file: $path for error: $e');
      return null;
    }
  }

  static Future<User> getUser() async {
    final testData = TestData<User>(mapper: Mapper<User>(parse: User.fromJson));

    return testData.getItem('test_data/user.json');
  }
}
