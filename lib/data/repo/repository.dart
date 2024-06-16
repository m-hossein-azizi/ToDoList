import 'package:flutter/material.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource {
  final DataSource<T> localDataSource;

  Repository({required this.localDataSource});
  @override
  Future<T> createOrupdate(data) async {
    final T result = await localDataSource.createOrupdate(data);
    notifyListeners();
    return result;
  }

  @override
  Future<void> delete(data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> deleteById(id) async {
    await localDataSource.deleteById(id);
    notifyListeners();
  }

  @override
  Future findById(id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List<TaskEntity>> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }
}
