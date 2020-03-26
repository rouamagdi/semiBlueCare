import 'package:loginn/ui/hospital_details.dart';

import 'package:flutter/material.dart';

class Private extends StatefulWidget {
  @override
  _PrivateState createState() => _PrivateState();
}

class _PrivateState extends State<Private> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth / 2 - 10;
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
                        height: 150,
                        color: Colors.blue,
                        child: Image.asset("assets/bg.jpeg", fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Total Care",
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
  }
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
