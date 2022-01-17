import 'package:digi_starts_covid/theme/botao.dart';
import 'package:digi_starts_covid/theme/cores.dart';
import 'package:digi_starts_covid/theme/texto_entrada.dart';
import 'package:digi_starts_covid/view/principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usuario = TextEditingController();
  TextEditingController _senha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            SvgPicture.asset(
              'images/svg/logo.svg',
              height: 150,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'DigistartsCOVID',
                style: TextStyle(
                  color: Cores.corSecundaria,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextoEntrada(
              controler: _usuario,
              Texto: 'Nome do usuário',
            ),
            TextoEntrada.senha(
              controler: _senha,
              Texto: 'Senha',
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Recuperar senha'),
                  ],
                ),
              ),
            ),
            Botao(
              funcao: () {
                if (_usuario.text == 'admin' && _senha.text == 'admin') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Principal(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: const Text('Digite um usuário e senha válido.'),
                      action: SnackBarAction(
                        label: 'Aviso',
                        onPressed: () {
                          // Código a ser executado
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ou continue com'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BotaoRedesSociais(imagem: 'images/svg/google.svg'),
                BotaoRedesSociais(imagem: 'images/svg/apple.svg'),
                BotaoRedesSociais(imagem: 'images/svg/facebook.svg'),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Não é membro?'),
            SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Text(
                'Registre-se agora',
                style: TextStyle(
                  color: Cores.corSecundaria,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
