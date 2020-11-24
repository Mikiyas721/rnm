import 'package:get_it/get_it.dart';
import './data/databaseManager.dart';

inject() async {
  GetIt.instance.registerSingleton(DatabaseManager());
}
