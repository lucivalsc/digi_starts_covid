import 'package:flutter/material.dart';

class TextoEntrada extends StatelessWidget {
  final String? Texto;
  final TextEditingController? controler;
  final Function()? funcao;
  final bool? visualizar;
  final bool? senha;
  const TextoEntrada({
    Key? key,
    this.Texto,
    this.controler,
    this.funcao,
    this.visualizar = false,
    this.senha = false,
  }) : super(key: key);
  const TextoEntrada.senha({
    Key? key,
    this.Texto,
    this.controler,
    this.funcao,
    this.visualizar = false,
    this.senha = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: senha!,
              controller: controler,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Texto,
              ),
            ),
          ),
          senha == true
              ? IconButton(
                  onPressed: funcao,
                  icon: visualizar == true
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off_outlined),
                )
              : Container(),
        ],
      ),
    );
  }
}
