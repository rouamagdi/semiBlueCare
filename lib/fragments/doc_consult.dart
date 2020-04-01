import 'dart:core';
import 'dart:core';
import 'dart:core' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/addconsult.dart';
import '../components/api_services.dart';
import '../components/consult.dart';
import '../components/doctor_articls.dart';
import '../localizations.dart';
import '../models/articls_model.dart';
import '../models/consult_model.dart';
import '../ui/chat_home.dart';

class DoctorCon extends StatefulWidget {
 Consult consult;
 int index;
 DoctorCon({this.consult,this.index});
  @override
  _DoctorConState createState() => _DoctorConState();
}

class _DoctorConState extends State<DoctorCon>
    with SingleTickerProviderStateMixin {
  @override
  BuildContext context;
  ApiService apiService;

  TabController tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
                  builder: (BuildContext context) => AddConsult()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 3,
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
                     Tab(text:  AppLocalizations.of(context).consulting),
                      Tab(text:  AppLocalizations.of(context).articls),
                      Tab(text:  AppLocalizations.of(context).researchs),
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
                  future: apiService.getConsults(),
                  builder: (BuildContext context, AsyncSnapshot<List<Consult>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        List<Consult> consults = snapshot.data;
                        return _buildListView1(consults);
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              FutureBuilder(
                future: apiService.getArticlss(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Articls>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      print(snapshot.data);
                      List<Articls> articls = snapshot.data;
                      return _buildListView(articls);
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: apiService.getArticlss(),
                builder: (BuildContext context,
                    AsyncSnapshot<prefix0.List<Articls>> snapshot) {
                  if (snapshot.hasData) {
                    prefix0.List<Articls> articls = snapshot.data;
                    return _buildListView(articls);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              // _buildListView(articls),
            ],
          ),
        ),
      ),
    );
  }


             
                

  Widget _buildListView(List<Articls> articls) {
    bool descTextShowFlag = false;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Articls articl = articls[index];


            return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                articl.title,
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text(articl.body,maxLines: descTextShowFlag ? 8 : 1,textAlign: TextAlign.start),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                    
                                      Navigator.pushReplacement(
                                    context,
                                          MaterialPageRoute(builder: (BuildContext context)
                                        => DoctorArticls(
                                          articl: articl,
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
                            ]))));
          },
          itemCount: articls.length,
        ));
  }


           

  Widget _buildListView1(List<Consult> consults) {
    bool descTextShowFlag = false;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Consult consult = consults[index];

            return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                              child:Text(consult.consultationBody, maxLines: descTextShowFlag ? 8 : 1,textAlign: TextAlign.start),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    
                                    child: Text(
                                       AppLocalizations.of(context).morebtn,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                    context,
                                          MaterialPageRoute(builder: (BuildContext context)
                                        => ConsultDetails(
                                          consult: consult,index: index,)
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ]))));
          },
          itemCount: consults.length,

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
