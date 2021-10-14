import 'package:appgestaoditalia/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FormAutenticaUsuario extends StatefulWidget {
  @override
  _FormAutenticaUsuarioState createState() => _FormAutenticaUsuarioState();
}

class _FormAutenticaUsuarioState extends State<FormAutenticaUsuario> {
  bool _isAutenticated = false;

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              height: 250,
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "WorkSansLight",
                            fontSize: 18.0),
                        filled: true,
                        fillColor: Colors.white24,
                        hintText: "E-mail",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.5)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.red,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // validator: (text){
                      //   if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                      // },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _passController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "WorkSansLight",
                            fontSize: 18.0),
                        filled: true,
                        fillColor: Colors.white24,
                        hintText: "Senha",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5)),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.red,
                        ),
                      ),
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscuringCharacter: "*",
                      // validator: (text){
                      //   if(text.isEmpty || text.length < 6) return "Senha inválida!";
                      // },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty)
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Insira seu e-mail para recuperação!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ));
                          else {
                            //model.recoverPass(_emailController.text);
                            //
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Confira seu e-mail!"),
                              backgroundColor: Colors.purple,
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        ),
                        //padding: EdgeInsets.zero,
                      ),
                    ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: new FloatingActionButton(
                        backgroundColor: Colors.red[900],
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}
                          // model.signIn(
                          //     email: _emailController.text,
                          //     pass: _passController.text,
                          //     onSuccess: _onSuccess(context),
                          //     onFail: _onFail(context)
                          // );
                          //_carregaPessoa();
                          //_obterIdPessoaPorEmail(_emailController.text);
                          _isAutenticated = true;

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _onSuccess(BuildContext context) {
  //    Navigator.of(context).pop(); //Esta dando erro
  // }

  // void _onFail(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Falha ao Entrar!"),
  //     backgroundColor: Colors.redAccent,
  //     duration: Duration(seconds: 3),
  //   ));
  // }
}
