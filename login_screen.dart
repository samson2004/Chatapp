import 'package:chatapp/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  final _auth=FirebaseAuth.instance;


  bool showspinner=false;
  late String email;
  late String pswd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: bluecolor,
       title: Text("Log-in",style: TextStyle(
         fontSize: 25
       ),),
     ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 150,
          width: 150,
          child: Image.asset('lib/images/facebooklogo.png'),
        ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value){
                    email=value!;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter pur Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
                child: TextField(
                  obscureText: true,
                  onChanged: (value){
                    pswd=value!;
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 80),
                  width: 400,
                  child: Text("Go-back?",textAlign: TextAlign.end,
                  style: TextStyle(
                    color: bluecolor,
                    fontSize: 13
                  ),),
                ),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return welcomescreen();
                    }));
                  });
                },
              ),
              GestureDetector(
                  onTap: ()async{
                    print(email);
                    print(pswd);
                    try{
                      setState(() {
                        showspinner=true;
                      });
                      final newuser= await _auth.signInWithEmailAndPassword(email: email, password: pswd);
                      if(newuser!=null){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return chatscreen();
                        }));

                      }
                    }
                    catch(e){
                      print(e);
                    }
                  },
                  child: welcomepagebuttons(textbutton: "Login",))
            ],
          ),
        ),
      ),
    );
  }
}
