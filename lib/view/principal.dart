import 'package:digi_starts_covid/controller/api_covid.dart';
import 'package:digi_starts_covid/controller/db_covid.dart';
import 'package:digi_starts_covid/model/model_covid.dart';
import 'package:digi_starts_covid/theme/cores.dart';
import 'package:digi_starts_covid/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final HttpService ServicoHttp = HttpService();
  ModelCovid covid = ModelCovid();
  ModelCabecalho covidCabecalho = ModelCabecalho();
  Databasecovid banco = Databasecovid.instance;
  String pesquisar =
      DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 10);

  String casos = '0';
  String mortes = '0';

  String DataInicial = DateFormat.yMd('pt_BR')
      .format(DateTime.now().subtract(Duration(days: 1)))
      .toString()
      .substring(0, 10);
  @override
  void initState() {
    super.initState();
    _valores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin@gmail.com'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Login(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _selectDate();
          await ServicoHttp.DadosCovid(pesquisa: pesquisar);
          _valores();
        },
        child: Icon(
          Icons.filter_alt_outlined,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'images/svg/logo.svg',
                        height: 25,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'COVID-19',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text('Coronavírus(Covid-19)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.public_outlined),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text('Casos - data dos dados: $DataInicial'),
                      ),
                    ],
                  ),
                  Text(
                    'Fonte: https://api.brasil.io',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Casos',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${formatter.format(int.parse(casos)).replaceAll('R\$', '')}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Cores.corPadrao,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Mortes',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${formatter.format(int.parse(mortes)).replaceAll('R\$', '')}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Cores.corSecundaria,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: ServicoHttp.DadosCovid(pesquisa: pesquisar),
                builder:
                    (context, AsyncSnapshot<List<ModelCabecalho>?> snapshot) {
                  if (snapshot.hasData) {
                    List<ModelCabecalho> dadoscovid = snapshot.data!;
                    return ListView(
                      children: dadoscovid
                          .map(
                            (e) => ListTile(
                              title: Text(
                                e.state!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                children: [
                                  _dados(
                                      'Casos: ${formatter.format(e.confirmed!).replaceAll('R\$', '')}',
                                      'Mortes: ${formatter.format(e.deaths!).replaceAll('R\$', '')}'),
                                  _Grafico(e.perc_casos, e.perc_mortes),
                                ],
                              ),
                              onTap: () {},
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dados(String Valor1, String Valor2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 40) / 2,
          child: Text('${Valor1}'),
        ),
        Expanded(
          child: Text('${Valor2}'),
        ),
      ],
    );
  }

  _Grafico(String? Tamanho1, String? Tamanho2) {
    double tamanho = ((MediaQuery.of(context).size.width - 40) / 2);

    double? valor1 =
        double.parse((tamanho * double.parse(Tamanho1!)).toStringAsFixed(0));

    double? valor2 =
        double.parse((tamanho * double.parse(Tamanho2!)).toStringAsFixed(0));

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          AnimatedContainer(
            width: valor1,
            height: 20,
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Cores.corPadrao,
            ),
          ),
          Container(width: tamanho - valor1),
          AnimatedContainer(
            width: valor2,
            height: 20,
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Cores.corSecundaria,
            ),
          ),
        ],
      ),
    );
  }

  Future _valores() async {
    var retorno = await banco.retornarPrincipal(pesquisar);
    setState(() {
      if (retorno.length > 0) {
        casos = retorno[0].casos ?? '0';
        mortes = retorno[0].mortes ?? '0';
        pesquisar = pesquisar;
      } else {
        casos = '0';
        mortes = '0';
      }
    });
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Cores.corPadrao,
                onPrimary: Colors.white,
                onSurface: Cores.corPadrao,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Cores.corPadrao, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2120));
    if (picked != null)
      setState(() {
        DataInicial = DateFormat.yMd('pt_BR').format(picked);
        pesquisar = picked.toString().substring(0, 10);
      });
  }
}
