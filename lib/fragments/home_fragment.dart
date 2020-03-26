import 'package:flutter/material.dart';

import '../components/goverment.dart';
import '../components/independent.dart';
import '../components/nearest.dart';
import '../components/private.dart';
import '../localizations.dart';
import '../ui/chat_home.dart';
import '../ui/notifications.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
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
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 50.0,
                  floating: true,
                  pinned: false,
                  flexibleSpace: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    height: 50,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF005ab3),
                        ),
                        hintText: "Search",
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black54),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {});
                          //FocusScope.of(context).requestFocus(_bf);
                        }
                      },
                    ),
                  )),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    // isScrollable: true,
                    indicatorColor: Color(0xFF005ab3),
                    labelColor: Color(0xFF005ab3),
                    unselectedLabelColor: Colors.black54,

                    tabs: [
                      Tab(text: AppLocalizations.of(context).closerHospital),
                      Tab(text:AppLocalizations.of(context).govHospital),
                      Tab(text: AppLocalizations.of(context).privetHospital),
                      Tab(text: AppLocalizations.of(context).independent),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(

                  //height: 450,
                  child: GridView.builder(
                      itemCount: 11,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .7),
                      itemBuilder: (BuildContext context, int index) {
                        return Nearest();
                      })),
              Container(
                  //height: 450,
                  child: GridView.builder(
                      itemCount: 11,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .7),
                      itemBuilder: (BuildContext context, int index) {
                        return Goverment();
                      })),
              Container(
                  //height: 450,
                  child: GridView.builder(
                      itemCount: 11,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .7),
                      itemBuilder: (BuildContext context, int index) {
                        return Private();
                      })),
              Container(
                  //height: 450,
                 /* child: GridView.builder(
                      itemCount: 11,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .7),
                      itemBuilder: (BuildContext context, int index) {
                        return Independent();
                      })*/
                       child:  Independent(), 
                      ),
            ],
          ),
        ),
      ),
    );
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
