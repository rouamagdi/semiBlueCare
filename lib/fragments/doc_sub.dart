import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/components/new_subscription.dart';
import 'package:loginn/models/consult_model.dart';
import 'package:loginn/models/subscribe_model.dart';

import '../components/doctor_reservation.dart';
import '../localizations.dart';
import '../ui/chat_home.dart';
import '../ui/notifications.dart';
Future getSubscribtions;
class DocSubscription extends StatefulWidget {
  //in the constructor, require a Response
Subscribtion sub;
 int index;
 DocSubscription({this.sub,this.index});
  @override
  _DocSubscriptionState createState() => _DocSubscriptionState();
}

class _DocSubscriptionState extends State<DocSubscription>    with SingleTickerProviderStateMixin {
  TabController tabController;
 @override
  BuildContext context;
  ApiService apiService;
  @override
  void initState() {
    super.initState();
     apiService = ApiService();
   getSubscribtions = ApiService().getSubscribtion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF005ab3),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.message, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Chat()));
              },
            );
          },
        ),
        title: Text('Blue Care'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Notifications()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    // isScrollable: true,
                    indicatorColor: Color(0xFF005ab3),
                    labelColor: Color(0xFF005ab3),
                    unselectedLabelColor: Colors.black54,

                    tabs: [
                      Tab(text: "current"),   //
                      Tab(text: "past"),// 
                     //  
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
           SafeArea(
                child: FutureBuilder(
                  future: getSubscribtions,
                  builder: ( context, snapshot) {
                    if (snapshot.hasData) {
                       print(snapshot.data);
                        List<Subscribtion> subscribtions = snapshot.data;
                      if (snapshot.data != null) {
                       
                        return _buildListView1(subscribtions);
                      }
                    } else if (snapshot.hasError){
                      
                      print(snapshot.error.toString());

                      return Center(
                        child: Text(snapshot.error.toString()),
                      );

                    } else {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.face
                              ),
                              Text("data"),

                             FlatButton(
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.black,
                                          shape: CircleBorder(),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            NewSubscription()));
                                          },
                                          child: Icon(Icons.add),),
                          ],
                        )
                      );
                    }
                  },
                ),
              ),
              Container(
                  //height: 450,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 12.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 24.0,
                        backgroundImage: AssetImage('assets/img/logo.png'),
                      ),
                      title: Row(
                        children: <Widget>[
                          Text(" date"),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "name",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      subtitle: Text("type of session"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DoctorReservation()));
                      },
                    ),
                  ],
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
   Widget _buildListView1(List<Subscribtion> subscribtions) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Subscribtion subscribe = subscribtions[index];

            return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text(subscribe.id),
                               Text(subscribe.differenceBetweenDates.toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    
                                    child: Text(
                                       AppLocalizations.of(context).morebtn,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                   /* onPressed: () {
                                      Navigator.pushReplacement(
                                    context,
                                          MaterialPageRoute(builder: (BuildContext context)
                                        => ConsultDetails(
                                          consult: consult,index: index,)
                                      ));
                                    },*/
                                  ),
                                ],
                              ),
                            ]))));
          },
          itemCount: subscribtions.length,

        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
