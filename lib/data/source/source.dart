import 'package:todolist/data/data.dart';

abstract class DataSource<T> {
  Future<List<TaskEntity>> getAll({String searchKeyword});
  Future<T> findById(dynamic id);
  Future<void> deleteAll();
  Future<void> delete(T data);
  Future<void> deleteById(dynamic id);
  Future<T> createOrupdate(T data);
}
