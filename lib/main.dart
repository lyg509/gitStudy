import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => SignInDetailsModel(),
        child: MyApp(),


      )
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Provider Sign-In Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title, home: HomePage(), debugShowCheckedModeBanner: false,
    );
  }


}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Login Example'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginRoute()),
                );
              },
              icon: Icon(Icons.person)),

        ],
      ),
      body: Center(child: Consumer<SignInDetailsModel>(
        builder: (context, userModel, child) {
          String message = (userModel.user == "" ? "Please sigin-in"
              : "Welcome ${userModel.user}");
          return Text(message, style: Theme
              .of(context)
              .textTheme
              .headline4);
        },
      )));
  }
}
class LoginRoute extends StatelessWidget{
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userField = TextField(
      style: style,
      controller: userNameTextController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "User Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.horizontal()
        )
      ),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.horizontal())),

    );
    final loginButton = Material(
      elevation: 5.0,
      color: Colors.blueAccent[400],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){
          Provider.of<SignInDetailsModel>(context,listen: false).signIn(userNameTextController.text);

          Navigator.pop(context);
        },
        child: Text("Sign-In",
        textAlign: TextAlign.center,
        style: style.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold )),
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25.0,),
                userField,
                SizedBox( height: 25.0,),
                passwordField,
                SizedBox( height: 25.0,),
                loginButton,
                SizedBox(height:  25.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInDetailsModel with ChangeNotifier{
  String _user="";
  DateTime? _signInOn;
  String get user => _user;
  DateTime? get signInOn => _signInOn;

  void signIn(String userName){
    _user = userName;
    _signInOn = DateTime.now();
    notifyListeners();
  }
}