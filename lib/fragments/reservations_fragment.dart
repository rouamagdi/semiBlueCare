import 'package:loginn/ui/MainPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/ui/chat_home.dart';
import 'package:loginn/ui/notifications.dart';
import 'package:loginn/components/UserReservation.dart';

import '../localizations.dart';


class ReservationsFragment extends StatefulWidget {
  Doctor doctor;

  @override
  _ReservationsFragmentState createState() => _ReservationsFragmentState();
}
 

class _ReservationsFragmentState extends State<ReservationsFragment>  {
    Map<String, dynamic> _payload;
   @override
  BuildContext context;
  ApiService apiService;

  TabController tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
   
  
    setState(() {
     // print(userAllReservationUrl);
      userReservation = ApiService().getuserReservations(userAllReservationUrl);
      
    });
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
        length: 1,
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
                      Tab(text:AppLocalizations.of(context).current, ),
                    //  Tab(text: AppLocalizations.of(context).past,),
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
                  future:userReservation,
                  builder: ( context,  snapshot) {
                 //    print("Snapshot => ${snapshot.toString()}");
                    print("URL => $userAllReservationUrl");
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.red,),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.deepPurple,),
                        );
                      default:
                        {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                      List< UserReservation> reservations = snapshot.data;
                        return _buildReservation(reservations);
                      }
                    } else if (snapshot.hasError){
                      print("Error ${snapshot.error}");
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else {
                            
                            return Text("كلامي شنو؟");
                          }
                    }
                  }}
                ),
              ),]),
        ),
      ),
    );
  }
}
 Widget _buildReservation(reservations) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            UserReservation userreservation = reservations[index];


            return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                               Divider(
                              height: 12.0,
                            ),
                              ListTile(
                              leading: CircleAvatar(
                                radius: 24.0,
                                backgroundImage:
                                    AssetImage('assets/img/logo.png'),
                              ),
                              title: Row(
                                children: <Widget>[
                                  Text(userreservation.statusDescription),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  Text(
                                    userreservation.age,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                              subtitle: Text("date"),
                             
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 14.0,
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                    
                                      Navigator.pushReplacement(
                                    context,
                                          MaterialPageRoute(builder: (BuildContext context)
                                        => Userreservation(
                                          userreservation: userreservation,
                                          index: index,
                                        )
                                      ));
                                    },
                                    child: Text(
                                      AppLocalizations.of(context).morebtn,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ]);
          },
          itemCount: reservations.length,
        ));
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
