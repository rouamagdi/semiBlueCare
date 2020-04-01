import 'package:loginn/models/center_model.dart';
import 'package:loginn/ui/hospital_details.dart';

import 'package:flutter/material.dart';

import 'api_services.dart';

class Private extends StatefulWidget {
  @override
  _PrivateState createState() => _PrivateState();
}
Future centery;
class _PrivateState extends State<Private> {
  String centersUrl = 'http://192.168.56.1:5000/api/centers/all';
 
   @override
  void initState() {
    super.initState();
    setState(() {
     
     centery = ApiService().getCenters(centersUrl);
      print(centersUrl);
    });}
  @override
   Widget build(BuildContext context) {
int index;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth / 2 - 10;
     return FutureBuilder(
          future: centery,
          builder:
              ( context, snapshot) {

            if (snapshot.hasData) {
              if (snapshot.data != null) {
               
                //print(snapshot.data.toString());
                List<Centery> centers = snapshot.data;
             
            
                              return _buildListView1(centers, context);
              }
            } else if (snapshot.hasError)  {
              return Text(
                snapshot.error.toString(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        );
  }}
   Widget _buildListView1(List<Centery> centers, context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double cardWidth = screenWidth / 2 - 10;
  return GridView.builder(
        itemCount: centers.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,),
                           
        itemBuilder: (context, index) {

       //   print(freelancers.length);
          Centery center = centers[index];
     
       
           if( center.isPrivate==true){
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 5),
          child: Card(
            elevation: 6.0,
            color: Colors.cyanAccent,
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HospitalDeitals()));
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: cardWidth,
                        height: 130,
                        color: Colors.blue,
                        child: Image.asset("assets/bg.jpeg", fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                         center.centerName,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("Near to 60th ST."),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
            width: 80,
            height: 20,
            margin: EdgeInsets.only(top: 25, left: 3),
            child: Material(
              elevation: 5,
              child: Center(
                child: Text(
                  "Private",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
),
              ),
            ))
      ],
    );
  
    }});
  }

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 16,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: 16,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: 16,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
