
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Notifications"),
      ),
      body: Column(
        //scrollDirection: Axis.vertical,
        children: <Widget>[

          Expanded(
            child: Container(

              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              
                            ),
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage("assets/img/person.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50,top: 50),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.comment,color: Colors.white,size: 10,),
                              ),
                            )

                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child: Row(
                              children: <Widget>[
                                //Text("قام ",style: TextStyle(fontSize: 14,),),
                                Text(" Ahmed Ali",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Liked your post",style: TextStyle(fontSize: 14),),
                              ],
                            )
                        ),

                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.chevron_right), onPressed: () {},)

                      ],
                    ),
                  ),

                  Container(
                    color: Colors.cyan.shade50,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                             
                            ),
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage("assets/img/person.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50,top: 50),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.comment,color: Colors.white,size: 10,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child:  Row(
                              children: <Widget>[
                                //Text("قام ",style: TextStyle(fontSize: 14,),),
                                Text(" Ahmed Ali",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Liked your post",style: TextStyle(fontSize: 14),),
                              ],
                            )
                        ),

                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.chevron_right), onPressed: () {},)

                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                             
                            ),
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage("assets/img/person.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50,top: 50),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.comment,color: Colors.white,size: 10,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child:  Row(
                              children: <Widget>[
                                //Text("قام ",style: TextStyle(fontSize: 14,),),
                                Text(" Ahmed Ali",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Liked your post",style: TextStyle(fontSize: 14),),
                              ],
                            )
                        ),

                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.chevron_right), onPressed: () {},)

                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              
                            ),
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage("assets/img/person.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50,top: 50),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.comment,color: Colors.white,size: 10,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child:  Row(
                              children: <Widget>[
                                //Text("قام ",style: TextStyle(fontSize: 14,),),
                                Text(" Ahmed Ali",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Liked your post",style: TextStyle(fontSize: 14),),
                              ],
                            )
                        ),

                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.chevron_right), onPressed: () {},)

                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              
                            ),
                            CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage("assets/img/person.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50,top: 50),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.comment,color: Colors.white,size: 10,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                            child:  Row(
                              children: <Widget>[
                                //Text("قام ",style: TextStyle(fontSize: 14,),),
                                Text(" Ahmed Ali",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                Text("Liked your post",style: TextStyle(fontSize: 14),),
                              ],
                            )
                        ),

                        SizedBox(width: 20,),

                        IconButton(icon: Icon(Icons.chevron_right), onPressed: () {},)

                      ],
                    ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
