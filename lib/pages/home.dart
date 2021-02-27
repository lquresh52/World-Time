import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data ={};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImg = data['isDayTime']?'day.png':'night.png';
    Color bgColor = data['isDayTime']?Colors.blue:Colors.indigo[700];
//    print(data);

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
            child: Column(
              children: [
                FlatButton.icon(
                    onPressed: () async {
                     dynamic result =  await Navigator.pushNamed(context, '/location');
                     setState(() {
                       data = {
                         'time': result['time'],
                         'location': result['location'],
                         'isDayTime': result['isDayTime'],
                         'flag': result['flag'],
                       };
                     });
                    } ,
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                          color: Colors.grey[300]
                      ),
                    ),
                ),
                SizedBox(height: 27.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        letterSpacing: 2.0,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 65.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
