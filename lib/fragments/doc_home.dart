import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/components/user_reservation.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/ui/doctor_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/doctor_reservation.dart';
import '../localizations.dart';
import '../ui/chat_home.dart';
import '../ui/notifications.dart';

class DocHome extends StatefulWidget {
  //in the constructor, require a Response

  @override
  _DocHomeState createState() => _DocHomeState();
}
//Doctor doctorData;

Future freeProfile;

class _DocHomeState extends State<DocHome> with SingleTickerProviderStateMixin {
  @override
  BuildContext context;
  ApiService apiService;
  Doctor _doctor;

  Map<String, dynamic> _payload;
  TabController tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(doctorAllReservationUrl);
      doctorReservation = ApiService().getReservations(doctorAllReservationUrl);
      print(doctorAllReservationUrl);
    });
    /*parseJwt().then((onValue) {
   
        _payload = onValue;
        if (_payload.isNotEmpty) {

          ApiService().getdoctor(doctorUrl).then((freelancerData){
            _doctor = freelancerData;
            doctorAllReservationUrl=doctorAllReservationUrl+_doctor.id;
            doctorReservation = ApiService().getReservations(doctorAllReservationUrl);
          });
         
        }
      });*/
    // doctorAllReservationUrl=doctorAllReservationUrl + payload['id'];
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
                      Tab(text: AppLocalizations.of(context).docrequest), //
                      //Tab(text:AppLocalizations.of(context).upcoming),//
                      //Tab(text:AppLocalizations.of(context).past),//
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(children: [
            SafeArea(
              child: FutureBuilder(
                  future: doctorReservation,
                  builder: (context, snapshot) {
                    print("Snapshot => ${snapshot.toString()}");
                    print("URL => $doctorAllReservationUrl");
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
                              List<Reservation> reservations = snapshot.data;
                              print(reservations.toString());
                              return _buildReservation(reservations);
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            print(snapshot.error);
                            return Text("كلامي شنو؟");
                          }
                        }
                    }
                  }),
            ),
          ]),
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
          Reservation reservation = reservations[index];

          return Column(
                          children: <Widget>[
                            Divider(
                              height: 3.0,
                              
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 24.0,
                                backgroundImage:
                                    AssetImage('assets/img/logo.png'),
                              ),
                              title: Row(
                                children: <Widget>[
                                  Text(reservation.statusDescription),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    reservation.age,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  
                                ],
                              ),
                              
                              subtitle: Text("date"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 14.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    
                                      Navigator.pushReplacement(
                                    context,
                                          MaterialPageRoute(builder: (BuildContext context)
                                        => DoctorReservation(
                                          reservation: reservation,
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
