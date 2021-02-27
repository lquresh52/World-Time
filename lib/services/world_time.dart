import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  String location;
  String time;
  String flag; // img name
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offset_min = data['utc_offset'].substring(4);
//      print(data['utc_offset']);
//      print(offset_min);

//
//    crate datetime obj
      DateTime now = DateTime.parse(datetime);
//      print(now);
      now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offset_min)));
//      print(now);
      isDayTime = now.hour > 6 && now.hour<20 ? true : false;
      time = DateFormat.jm().format(now);

    }catch(e){
      time = 'Could not get time data';
    }

  }
}