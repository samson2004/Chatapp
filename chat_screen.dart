  import 'package:chatapp/main.dart';
import 'package:chatapp/welcome_screen.dart';
  import 'package:flutter/material.dart';
  import 'registerscreen.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'constants.dart';

  class chatscreen extends StatefulWidget {
    const chatscreen({super.key});

    @override
    State<chatscreen> createState() => _chatscreenState();
  }

  class _chatscreenState extends State<chatscreen> {

    final _firestore=FirebaseFirestore.instance;
    final _auth=FirebaseAuth.instance;
    late String User="XX-> Your Email <-XX";
    late String message;
    bool showspinner=false;
    bool isMe=false;
    final TextEditingController _messagecontroller=TextEditingController();
    final ScrollController _scrollController=ScrollController();



    @override
    void initState() {
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: bluecolor,
          title: Text("Chat-Box",textAlign: TextAlign.center,style: TextStyle(
            color: Colors.white,
          ),),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return welcomescreen();
              }));
              // _auth.signOut();
              // Navigator.push(context, MaterialPageRoute(builder: (context){
              //   return chatapp();}));
              },
                icon: Icon(Icons.close))

          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: StreamBuilder(
                    stream: _firestore.collection("messages").orderBy("timestamp",)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final snapshotmessages = snapshot.data?.docs;
                        List<Widget> messageWidgets = [];

                        snapshotmessages?.forEach((message) {
                          final messageText = message.data()['text'];
                          final messageSender = message.data()['sender'];
                          final messagetimestamp=message.data()['timestamp'] as Timestamp?;

                          final timestamp=messagetimestamp?? Timestamp.now();
                          final ismyMessage=_auth.currentUser?.email == messageSender;

                          final messageWidget = messagebubble(messageSender,messageText,timestamp,ismyMessage);
                          messageWidgets.add(messageWidget);



                        });

                        return Container(
                          child: ListView(
                            controller: _scrollController,
                            children: messageWidgets,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // Handle the error case
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Display a loading indicator while data is being fetched
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),


              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 30, 20, 0),
                    child: TextField(
                      controller: _messagecontroller,
                      onChanged: (value){
                        message=value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)
                          ),
                          hintText: "Type your message here..."
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print("send Clicked");
                    print(message);
                    if(message!=null){
                      _firestore.collection('messages').add({
                        'text':message,
                        'sender':_auth.currentUser?.email,
                        'timestamp':FieldValue.serverTimestamp()
                      });;
                      _messagecontroller.clear();
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds:800 ), curve: Curves.ease);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 10, 0),
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    width: 80,
                    height: 50,
                    child: Icon(Icons.send,color: Colors.white,),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                )
              ],
            ),],
          ),
        ),
      );
    }
  }


  class messagebubble extends StatelessWidget {
    messagebubble(this.sender, this.text,this.timestamp,this.ismyMessage);

    final String sender;
    final String text;
    Timestamp timestamp;
    bool ismyMessage;


    @override
    Widget build(BuildContext context) {
      return Material(
        color: whitecolor,
        child: Column(
          crossAxisAlignment: ismyMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text("$sender"),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
              child: Text('$text', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),),
              decoration: BoxDecoration(
                color: ismyMessage?Colors.lightBlueAccent:Colors.redAccent,
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],

        ),
      );
    }
  }