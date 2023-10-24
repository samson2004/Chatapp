import 'package:chatapp/login_screen.dart';
import 'package:chatapp/registerscreen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class welcomescreen extends StatefulWidget {
  const welcomescreen({super.key});

  @override
  State<welcomescreen> createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    height: 150,
                    width: 150,
                    child: Image.asset('lib/images/facebooklogo.png'),
                  ),
                  Text("Facebook ",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25
                  ),),
                  Text("AIR",style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: bluecolor
                  ),)
                ],
              ),
              GestureDetector(
                  child: welcomepagebuttons(textbutton: "Login",),
              onTap: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return loginscreen();
                      }));
                    });
              },),
              GestureDetector(
                child: welcomepagebuttons(textbutton: "Register",),
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return registerscreen();
                    }));
                  });
                },),
            ],
          ),
        ),
      ),
    );
  }
}

