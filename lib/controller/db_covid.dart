import 'dart:async';
import 'dart:io';
import 'package:digi_starts_covid/model/model_covid.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Databasecovid {
  Databasecovid._privateConstructor();
  static final Databasecovid instance = Databasecovid._privateConstructor();
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  final SQLtabelaCovid = '''
              CREATE TABLE $tabelaCovid (
                        $city TEXT,
                        $cityIbgeCode TEXT,
                        $confirmed TEXT,
                        $confirmedPer100kInhabitants TEXT,
                        $date TEXT,
                        $deathRate TEXT,
                        $deaths TEXT,
                        $estimatedPopulation TEXT,
                        $estimatedPopulation2019 TEXT,
                        $isLast TEXT,
                        $orderForPlace TEXT,
                        $placeType TEXT,
                        $state TEXT
              );
  ''';

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(SQLtabelaCovid);
  }

  Future<void> inserir(ModelCovid emprestar) async {
    Database? dbPadrao = await db;
    await dbPadrao!.insert(tabelaCovid, emprestar.toJson());
    return null;
  }

  Future<List?> retornar(String data) async {
    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!.query(
      tabelaCovid,
      columns: [
        date,
      ],
      where: '$date = ?',
      whereArgs: [data],
    );

    List<ModelCovid> listaCovid = [];
    for (Map m in listMap) {
      listaCovid.add(ModelCovid.fromJson(m));
    }
    return listaCovid;
  }

  Future<List> retornarTodosRegistros(String data) async {
    Database? dbPadrao = await db;
    List listMap = await dbPadrao!.rawQuery(''' 
                      SELECT 
                        $city ,
                        $cityIbgeCode ,
                        SUM($confirmed) confirmed,
                        $confirmedPer100kInhabitants ,
                        $date ,
                        $deathRate ,
                        SUM($deaths) deaths,
                        $estimatedPopulation ,
                        $estimatedPopulation2019 ,
                        $isLast ,
                        $orderForPlace ,
                        $placeType ,
                        $state 
                      FROM $tabelaCovid 
                      WHERE $date LIKE '$data' 
                      GROUP BY 
                        $city ,
                        $cityIbgeCode ,
                        $confirmedPer100kInhabitants ,
                        $date ,
                        $deathRate ,
                        $estimatedPopulation ,
                        $estimatedPopulation2019 ,
                        $isLast ,
                        $orderForPlace ,
                        $placeType ,
                        $state 
                      ORDER BY $state
                      ''');
    List<ModelCovid> listaCovid = [];
    for (Map m in listMap) {
      listaCovid.add(ModelCovid.fromJson(m));
    }
    return listaCovid;
  }

  Future<List<ModelCabecalho>> retornarPrincipal(String data) async {
    Database? dbPadrao = await db;
    List listMap = await dbPadrao!.rawQuery(''' 
                      SELECT
                        $state,
                        $confirmed,
                        $deaths,
                        casos,
                        mortes,
                        (CAST(confirmed AS DOUBLE) / CAST(casos AS DOUBLE)) * 2 perc_casos,
                        (CAST(deaths AS DOUBLE) / CAST(mortes AS DOUBLE)) * 2 perc_mortes
                      FROM(SELECT 
                      $state, 
                      SUM($confirmed) confirmed, 
                      SUM($deaths) deaths,
                      (SELECT SUM($confirmed) CASOS FROM $tabelaCovid WHERE $date = '$data') casos,
                      (SELECT SUM($deaths) CASOS FROM $tabelaCovid WHERE $date = '$data') mortes
                      FROM $tabelaCovid 
                      WHERE $date = '$data' 
                      GROUP BY 
                        $state) 
                  ''');

    List<ModelCabecalho> listaCovid = [];
    for (Map m in listMap) {
      listaCovid.add(ModelCabecalho.fromJson(m));
    }
    return listaCovid;
  }

  Future deletarTudo() async {
    Database? dbPadrao = await db;
    await dbPadrao!.delete(tabelaCovid);
  }

  Future<int?> registroAtual(String? dataAtual) async {
    Database? dbPadrao = await db;
    int valor = Sqflite.firstIntValue(
      await dbPadrao!.rawQuery('''
            SELECT COUNT(*) FROM $tabelaCovid
            WHERE $date LIKE '$dataAtual'
      '''),
    );
    return valor;
  }

  Future close() async {
    Database? dbPadrao = await db;
    dbPadrao!.close();
  }
}
