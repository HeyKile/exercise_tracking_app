import 'package:flutter/material.dart';
import 'TemplateList.dart';
import 'package:exercise_tracking_app/views/WorkoutView.dart';
import 'package:exercise_tracking_app/models/TemplateModel.dart';

class WorkoutOptions extends StatelessWidget {
  WorkoutOptions({super.key});
  
    @override
    Widget build(BuildContext context) {
      return Column(children: [
        Container(
        width: double.infinity,
        color: Color.fromARGB(255, 0, 149, 255),
        padding: new EdgeInsets.all(50.0),
        child:Align(alignment: Alignment.center, 
        child: Text("Add a New Workout", style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold)))),
        SizedBox(height: 150,),
        Container(height: 70, width: 300, child:TextButton.icon(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(isLive:true)));
          }, label: Text("Track Live", style: TextStyle(color: Colors.white, fontSize: 24)), 
          icon: Icon(Icons.radio_button_checked, color: Colors.white, size:40), 
          style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8))),
            backgroundColor: Color.fromARGB(255, 0, 149, 255)))),
       SizedBox(height: 10,),
       Container(height: 70, width: 300,  child:TextButton.icon(onPressed: (){
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(isLive:false)));
          }
        , label: Text("Log Past Workout", style: TextStyle(color: Colors.white, fontSize: 24)), 
        icon: Icon(Icons.history, color: Colors.white, size: 40),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8))),
            backgroundColor: Color.fromARGB(255, 0, 149, 255)))),
      ],);
    }

}

class SecondRoute extends StatelessWidget {
  SecondRoute({super.key, required this.isLive});
  bool isLive;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Workout Template'),
      ),
      body: Center(
        child: TemplateList(isWorkout: true, chooseTemplate: (Template? template) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutView(isLive: isLive, template: template)));
          }
          )
        
      ),
    );
  }
  
}