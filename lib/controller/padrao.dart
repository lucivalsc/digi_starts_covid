import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> BaseUrl() async {
  return 'https://api.brasil.io/v1/dataset/covid19/caso/data/?';
}

Future<bool?> TestarConexao(BuildContext? context) async {
  var url = Uri.parse(await BaseUrl());
  try {
    final http.Response response = await http.get(url, headers: {
      'authorization': 'Token 8b34c604f8c467c5950550f6870bde20dc5229fb'
    });
    return true;
  } catch (e) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        content: const Text('Erro ao conectar no servidor.'),
        action: SnackBarAction(
          label: 'Aviso',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
    return false;
  }
}
