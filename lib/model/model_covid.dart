final String databaseName = 'database10';
final int databaseVersion = 1;
final String tabelaCovid = 'covid';

final String city = 'city';
final String cityIbgeCode = 'city_ibge_code';
final String confirmed = 'confirmed';
final String confirmedPer100kInhabitants = 'confirmed_per_100k_inhabitants';
final String date = 'date';
final String deathRate = 'death_rate';
final String deaths = 'deaths';
final String estimatedPopulation = 'estimated_population';
final String estimatedPopulation2019 = 'estimated_population_2019';
final String isLast = 'is_last';
final String orderForPlace = 'order_for_place';
final String placeType = 'place_type';
final String state = 'state';

class ModelCovid {
  String? city;
  String? cityIbgeCode;
  int? confirmed;
  String? confirmedPer100kInhabitants;
  String? date;
  String? deathRate;
  int? deaths;
  String? estimatedPopulation;
  String? estimatedPopulation2019;
  String? isLast;
  String? orderForPlace;
  String? placeType;
  String? state;

  ModelCovid();

  ModelCovid.fromJson(Map map) {
    city = map['city'] ?? '';
    cityIbgeCode = map['city_ibge_code'] ?? '';
    confirmed = map['confirmed'];
    confirmedPer100kInhabitants =
        map['confirmed_per_100k_inhabitants'].toString();
    date = map['date'] ?? '';
    deathRate = map['death_rate'].toString();
    deaths = map['deaths'];
    estimatedPopulation = map['estimated_population'].toString();
    estimatedPopulation2019 = map['estimated_population_2019'].toString();
    isLast = map['is_last'].toString();
    orderForPlace = map['order_for_place'].toString();
    placeType = map['place_type'] ?? '';
    state = map['state'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['city_ibge_code'] = this.cityIbgeCode;
    data['confirmed'] = this.confirmed;
    data['confirmed_per_100k_inhabitants'] = this.confirmedPer100kInhabitants;
    data['date'] = this.date;
    data['death_rate'] = this.deathRate;
    data['deaths'] = this.deaths;
    data['estimated_population'] = this.estimatedPopulation;
    data['estimated_population_2019'] = this.estimatedPopulation2019;
    data['is_last'] = this.isLast;
    data['order_for_place'] = this.orderForPlace;
    data['place_type'] = this.placeType;
    data['state'] = this.state;
    return data;
  }
}

class ModelCabecalho {
  int? confirmed;
  int? deaths;
  String? casos;
  String? mortes;
  String? perc_casos;
  String? perc_mortes;
  String? state;

  ModelCabecalho();

  ModelCabecalho.fromJson(Map map) {
    confirmed = map['confirmed'];
    deaths = map['deaths'];
    deaths = map['deaths'];
    casos = map['casos'].toString();
    mortes = map['mortes'].toString();
    perc_casos = map['perc_casos'].toString();
    perc_mortes = map['perc_mortes'].toString();
    state = map['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['state'] = this.state;
    return data;
  }
}
