import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';

class DatabaseManager {
  late Database connection;

  DatabaseManager() {
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
    connection = sqlite3.open(join(Directory.current.path, "veritabani"));
  }

  DynamicLibrary _openOnWindows() {
    final String libPath = join(Directory.current.path, "sqlite3.dll");
    return DynamicLibrary.open(libPath);
  }

  ResultSet getCarDetail(int id) {
    final ResultSet results =
        connection.select("select * from bilet where code = ?", [id]);
    return results;
  }

  void addCar(Map bilet) {
    final stmt = connection.prepare(
        'INSERT INTO bilet (code,price,link,title) VALUES (?,?,?,?)');
    stmt.execute([
      bilet["code"],
      bilet["price"],
      bilet["link"],
      bilet["title"]
    ]);
    stmt.dispose();
  }
}
