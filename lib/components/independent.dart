import 'package:flutter/material.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/ui/doctor_profile.dart';

import '../ui/doctor_details.dart';
import 'api_services.dart';

class Independent extends StatefulWidget {
  @override
  _IndependentState createState() => _IndependentState();
}
Future freelancers;
class _IndependentState extends State<Independent> {
  BuildContext context;
  ApiService apiService;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     freelancers = ApiService().getFreelancers();
  }

  @override
  Widget build(BuildContext context) {
  

    return FutureBuilder(
          future: freelancers,
          builder:
              ( context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                //print(snapshot.data.toString());
                List<Doctor> freelancers = snapshot.data;
                return _buildListView1(freelancers, context);
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
     
  }
}

Widget _buildListView1(List<Doctor> freelancers, context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double cardWidth = screenWidth / 2 - 10;
  return GridView.builder(
        itemCount: freelancers.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,),
        itemBuilder: (context, index) {
       //   print(freelancers.length);
          Doctor allfreelancer = freelancers[index];
return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 5), 
           child:  Card(
              elevation: 6.0,
              color: Colors.cyanAccent,
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DoctorProfile(doctor :allfreelancer,index:index)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: cardWidth,
                          height: 100,
                          
                          color: Colors.blue,
                          child:
                              Image.asset("assets/bg.jpeg", fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            allfreelancer.freelancerName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,  color: Colors.black12,fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(allfreelancer.id.toString()),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
          )),]);
        });
  
  
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
