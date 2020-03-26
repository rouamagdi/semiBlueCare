import 'package:flutter/material.dart';

import 'chat_user_builder.dart';
class Chat extends StatefulWidget {
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {

   final double minValue = 8.0;
Widget _buildChatBody() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(minValue * 5),
          topRight: Radius.circular(minValue * 5)),
      child: Container(
        width: MediaQuery.of(context).size.width,
//        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(minValue * 2),
              child: Text("My Recent Chats"),
            ),
            Expanded(child: MyChatUserBuilder())
          ],
        ),
      ),
    );
  }


 

  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
//        backgroundColor: Theme.of(context).primaryColor,
        drawer: Drawer(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
            
//              MyCounterBody(),
              Expanded(child: _buildChatBody())
            ],
          ),
        ),
      ),
    );
   

             
  }

}
