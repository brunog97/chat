import 'package:flutter/material.dart';
import 'package:personal_expenses/models/auth.data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authdata) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();
  final FocusNode _myFocus = FocusNode();

  _submit() {
    bool isValid = _formKey.currentState!
        .validate(); //persistindo a validação do formulario

    FocusScope.of(context).unfocus(); //Fecha o teclado ao submeter

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      focusNode: _myFocus,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      initialValue: _authData.name,
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve possuir no minimo quatro caracteres';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    initialValue: _authData.email,
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail valido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    initialValue: _authData.password,
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 8) {
                        return 'Senha deve possuir no minimo oito caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_authData.isLogin ? 'Login' : 'Cadastrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                        if (_authData.isSignup)
                          FocusScope.of(context).requestFocus(_myFocus);
                      });
                    },
                    child: Text(_authData.isLogin
                        ? 'Criar uma nova conta?'
                        : 'Já possuo cadastro'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
