import 'dart:convert';
import 'package:digi_starts_covid/controller/db_covid.dart';
import 'package:digi_starts_covid/controller/padrao.dart';
import 'package:digi_starts_covid/model/model_covid.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<List<ModelCabecalho>?> DadosCovid({String? pesquisa}) async {
    Databasecovid banco = Databasecovid.instance;

    String Url = pesquisa == null || pesquisa.isEmpty
        ? await BaseUrl() + ''
        : await BaseUrl() + 'date=${pesquisa}';

    if (await banco.registroAtual(pesquisa) == 0) {
      if (pesquisa != null || pesquisa!.isNotEmpty) {
        final response = await http.get(
          Uri.parse(Url),
          headers: {
            'authorization': 'Token 8b34c604f8c467c5950550f6870bde20dc5229fb'
          },
        );

        if (response.statusCode == 200) {
          List<dynamic> body = jsonDecode(response.body)['results'];

          List<ModelCovid> covid = body.map((dynamic item) {
            banco.inserir(ModelCovid.fromJson(item));
            return ModelCovid.fromJson(item);
          }).toList();

          return banco.retornarPrincipal(pesquisa);
        }
      }
    } else {
      return banco.retornarPrincipal(pesquisa!);
    }
  }
}
