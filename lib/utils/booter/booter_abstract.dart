part of 'app_booter_cubit.dart';

abstract class Booter<T> {
  Future<T> bootUp();

  void onBootUp();

  void bootDown();
}
