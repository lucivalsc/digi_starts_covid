import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:digi_starts_covid/theme/cores.dart';

class Botao extends StatelessWidget {
  final Function()? funcao;
  const Botao({
    Key? key,
    this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Cores.corSecundaria,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: funcao,
        child: Center(
          child: Text(
            'Entrar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BotaoRedesSociais extends StatelessWidget {
  final String? imagem;
  final Function()? funcao;
  const BotaoRedesSociais({
    Key? key,
    this.imagem,
    this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: funcao,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: imagem != null
            ? SvgPicture.asset(
                imagem!,
                color: Colors.black26,
              )
            : Container(),
      ),
    );
  }
}
