import 'package:covidupdate/homepage.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import '../homepage.dart';


class LoginScreen extends StatefulWidget {
  static const routeName ='/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey= GlobalKey();

  Map<String,String> _authData={
    'email':'',
    'password':''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(context: context,
    builder: (ctx)=>AlertDialog(
      title: Text('An Error Occured'),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
          child:Text('ok'),
          onPressed: (){
            Navigator.of(ctx).pop();
          }
        )
      ],
    )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
      {
        return;
      }
    _formKey.currentState.save();
    try{
      await Provider.of<Authentication>(context,listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }catch(error)
    {
      var errorMessage='Authentication failed try again later';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text("Sign Up",style: TextStyle(fontStyle: FontStyle.italic,fontSize:(15),fontWeight: FontWeight.bold,color: Colors.white)
                ),
                Icon(Icons.person_add,color: Colors.white,)
              ],
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                ]
              )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                              {
                                return 'invalid Email';
                              }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email']=value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value.length<5){
                              return 'Error processing password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password']=value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text("Submit"),
                          onPressed:()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
