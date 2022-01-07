import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:castorstatistics/discover_page.dart';
import 'package:get/get.dart';


class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  String? mail;
  String? mdp;
  final _key = new GlobalKey<FormState>();
  check(){
    final form = _key.currentState;
    if(form!.validate()){
      form.save();
      login();
    }
  }
  login() async{
    Uri url = Uri.parse('http://10.0.2.2/API.php');
    Map<String, String> headers = {
      'Charset': 'utf-8'
    };
    var bodyy = {
      "mail" :mail,
      "mdp" :mdp
    }
    ;
    final response = await http.post(url,body: bodyy);
    final data = jsonDecode(jsonEncode(response.body));
    print(data);
    if(data=="1"){
      onTappedd();
    }else{
      showDialog(
          context: context,
          builder: (ctxt) => new AlertDialog(
            title: Text("Erreur dans les identifiants"),
          )
      );
    }
  }
  bool _secureText = false;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff121421),
          title: Text("CONNEXION",style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          )),

        ), // AppBar
        body:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.green.shade400,
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Image.asset('assets/images/profile.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                      child:Container(

                        padding: EdgeInsets.symmetric(horizontal: 32),
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 8,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        child: Form(
                          key: _key,
                          child: ListView(
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                validator: (e){
                                  if(e!.isEmpty) {
                                    return "Champ vide";
                                  }
                                },
                                onSaved: (e) => mail = e,
                                decoration: InputDecoration(
                                    labelText: "Email"
                                ),
                              ), // TextFormField
                              TextFormField(
                                controller: passwordController,
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "Champ vide";
                                  }
                                },
                                obscureText: _secureText,
                                onSaved: (e) => mdp = e,
                                decoration: InputDecoration(
                                  labelText: "Mot de passe",
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(
                                        _secureText ?Icons.visibility_off : Icons.visibility
                                    ), // Icon
                                  ),
                                ), // InputDecoration
                              ),
                              MaterialButton(
                                color: Colors.green.shade400,
                                onPressed: (){
                                  check();
                                },
                                child: Text("Login"),
                              )
                            ],
                          ),
                        ),
                      ))])));
  }

}

void onTappedd() {
  Get.to(()=> DiscoverPage(), transition: Transition.rightToLeft);
}
