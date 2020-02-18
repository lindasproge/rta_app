import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email'
    ]
);

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => new _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Sign in'),
        ),
        body: _buildBody()
    );
  }

  Widget _buildBody(){
    if(_currentUser != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          RaisedButton(
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
          )
        ],
      );
    }
    else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(''),
          RaisedButton(
              onPressed: _handleSignIn,
              child: Text('SIGN IN')
          )
        ],
      );
    }
  }

  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
    }catch(error){
      print(error);
    }
  }

  Future<void> _handleSignOut() async{
    _googleSignIn.disconnect();
  }
}