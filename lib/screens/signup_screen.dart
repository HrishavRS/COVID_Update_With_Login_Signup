import 'package:covidupdate/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/authentication.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';
import '../homepage.dart';

class SignupScreen extends StatefulWidget {
  static const routeName='/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey= GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

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

  Future <void> _submit() async
  {
    if(!_formKey.currentState.validate())
      {
        return;
      }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context,listen: false).signUp(
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
        title: Text('SignUp Screen'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text("Login",style: TextStyle(fontStyle: FontStyle.italic,fontSize:(15),fontWeight: FontWeight.bold,color: Colors.white)
                ),
                Icon(Icons.person,color: Colors.white,)
              ],
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
                      Colors.limeAccent,

                    ]
                )
            ),
          ),
          Center(
            child: Card(
              color: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 350,
                width: 350,
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
                              return 'invalud Email';
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
                          controller: _passwordController,
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
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty || value!=_passwordController.text){
                              return 'Error processing password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

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
                          color: Colors.white,
                          textColor: Colors.black,
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
