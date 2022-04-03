import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
class calAge extends StatefulWidget {

  @override
  State<calAge> createState() => _calAgeState();
}

class _calAgeState extends State<calAge> {
  var textcontrol=TextEditingController();
  var textcontrol2=TextEditingController();
  int ?year;
  int ?month;
  int ?day;
  bool bottomshow=false;
  int ?year2;
  int ?month2;
  int ?day2;
  bool bottomshow2=false;
  bool check=false;
  List<String>image=['1.jpg','2.jpg','3.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calclute age'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             CarouselSlider(items: image.map((e) =>Image(
                image:AssetImage('images/$e'),
                width: double.infinity,
              )).toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      viewportFraction: 1,
                      initialPage: 0,
                      scrollDirection: Axis.horizontal,
                      reverse: false,

                  )),
              SizedBox(height: 15,),
              MaterialButton(

                  color: Colors.amberAccent,
                  onPressed: (){
                    DatePicker.showDatePicker(context,
                      maxDateTime:DateTime(2022,4),
                      minDateTime: DateTime(1900),
                      initialDateTime: DateTime.now(),
                      // dateFormat: 'yyyy-MM',
                      onConfirm:(DateTime dateTime, List<int> selectedIndex){
                       year=dateTime.year;
                       day=dateTime.day;
                       month=dateTime.month;
                     textcontrol.text='$year - $month -$day';

                     setState(() {
                       bottomshow=true;
                     });
                    });

                  },child: Text('enter Date of Birth'),),
              SizedBox(height: 10,),
              if(bottomshow)
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: textcontrol,
                 enableInteractiveSelection: false,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.black26,
                    border:OutlineInputBorder(),
                    hintText: 'date of parse day',
                  ),

                ),
              ),
              SizedBox(height: 10,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(value: check ,onChanged:(value)
              {
                    DatePicker.showDatePicker(context,
                        maxDateTime:DateTime(2022,4),
                        minDateTime: DateTime(1900),
                        initialDateTime: DateTime.now(),
                        // dateFormat: 'yyyy-MM',
                        onConfirm:(DateTime dateTime, List<int> selectedIndex){
                          year2=dateTime.year;
                          day2=dateTime.day;
                          month2=dateTime.month;
                          textcontrol2.text='$year2 - $month2 -$day2';

                          setState(() {
                            bottomshow2=true;
                            check=true;
                          });
                        });
                    setState(() {
                       check=value!;
                       if(check ==false){
                         year2=null;
                         day2=null;
                         month2=null;
                         bottomshow2=false;

                       }

                    });
              },
              activeColor: Colors.cyanAccent,
              checkColor: Colors.black,
              ),
                   // SizedBox(width: 5,),
                    Text('date of death')
                  ],
                ),
              SizedBox(height: 10,),
              if(bottomshow2)
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.none,
                    controller: textcontrol2,
                    enableInteractiveSelection: false,
                    enabled: false,
                    decoration: InputDecoration(
                      fillColor: Colors.black26,
                      border:OutlineInputBorder(),
                      hintText: 'date of parse day',
                    ),

                  ),
                ),
              SizedBox(height: 15,),
              MaterialButton(onPressed: ()async{
               if(year!=null){
                 if(year2==null)year2=(DateTime.now().year);
                 if(month2==null)month2=DateTime.now().month;
                 if(day2==null)day2=DateTime.now().day;
                if (await confirm(context ,title: Text('your age is :'),content:Text('${year2!-year!} years ${month2!-month!} Months ${day2!-day!} days',style:TextStyle(fontSize: 18)) )) {
                return print('pressedOK');
                }
                return print('pressedCancel');


               }
               else Fluttertoast.showToast(msg: 'please enter Date of Birth',
                 backgroundColor: Colors.red,
                 toastLength: Toast.LENGTH_LONG,
                 gravity: ToastGravity.CENTER,
                 webShowClose: true,
                 timeInSecForIosWeb: 6,
               );

              },child: Text('Calculate Your Age'),color: Colors.amberAccent,)
              


            ],
          ),
        ),
      ),

    );
  }
}
