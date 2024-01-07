import "package:assignment/models/locations.dart";
import "package:country_flags/country_flags.dart";
import "package:flutter/material.dart";
import 'package:azlistview/src/index_bar.dart';
import 'dart:math';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationWidget()
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  _LocationWidgetState() {
    display_list.sort((a, b) =>
        a.location_name!.compareTo(b.location_name!));
  }

  static List<LocationModel> location_list = [
    LocationModel('Bangalore', "IND", false),
    LocationModel('Frankfurt', 'AFG', false),
    LocationModel('Amsterdam', 'NED', false),
    LocationModel('Saint-Eithenne','FRA', false),
    LocationModel('Paris', 'FRA', false),
    LocationModel('Mumbai', 'IND', false),
    LocationModel('Hanoi', 'VNM', false),
    LocationModel('Texas', 'USA', false),
    LocationModel('Cape Town', 'RSA', false),
    LocationModel('Pondicherry', 'IND', false),
  ];

  List<LocationModel> display_list = List.from(location_list);
  bool? isChecked = false;
  bool isMinimized = false;
  bool isCollapsed = false;

  void updateList(String value) {
    setState(() {
      display_list = location_list
          .where((element) =>
          element.location_name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      display_list.sort((a, b) => a.location_name!.compareTo(b.location_name!));
    });
  }

  List<String> fillIndexes(){
    List<String> dummy_array = [location_list[0].location_name![0]];
    for(int index = 1; index < location_list.length; index++){
      String nextVal = location_list[index].location_name![0];
      if(dummy_array.last != nextVal) dummy_array.add(nextVal);
    }

    return dummy_array;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!isMinimized && !isCollapsed)
                   Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Text(
                      "Location",
                      style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                      width: 160
                      ),
                      IconButton(onPressed: () {
                      setState(() {
                      isMinimized = true;
                      });
                      }, icon: Icon(Icons.minimize),),
                      IconButton(onPressed: () {
                          setState(() {
                          isCollapsed = true;
                          });
                          },
                           icon: Icon(Icons.door_sliding),)
                              ],
                   )

            else if(!isMinimized && isCollapsed)
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    IconButton(onPressed: (){
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    }, icon: Icon(Icons.plus_one),)
                  ],
                ),
              )

            else
              RotatedBox(
              quarterTurns: 3,
              child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
              onPressed: () {},
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
              "Location",
              style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontSize: 24,
              fontWeight: FontWeight.w400),
              ),
              IconButton(onPressed: (){
              setState(() {
              isMinimized = !isMinimized;
              });
              }, icon: Icon(Icons.plus_one),)
              ],
              ),
              ),
              ),
                SizedBox(
                  height: 20.0,
                ),
        
                Expanded(
                  child: Visibility(
                    visible: !isMinimized && !isCollapsed,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) => updateList(value),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none),
                              hintText: "filter locations",
                              prefixIcon: Icon(Icons.search),
                              prefixIconColor: Colors.black),
                        ),
        
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
                        onPressed: () {
                          setState(() {
                            for(int index = 0; index < display_list.length; index++){
                            display_list[index].isChecked = false;
                          }});
                        },
                        child: Text('Clear all')
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
        
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: display_list.length,
                                  itemBuilder: (context, index) => ListTile(
                                    leading: Checkbox(
                                      value: display_list[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                              display_list[index].isChecked = value;
                                        });
                                      },
                                    ),
                                    title: Row(
                                      children: [
                                        Text(display_list[index].country_name!),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CountryFlag.fromCountryCode(display_list[index].country_name!, height: 20, width: 20, borderRadius: 8,),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(display_list[index].location_name!,
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),

                                  ),

                              )
                          ),
                          IndexBar(
                            data: fillIndexes(),
                          ),
                        ],
                      ),
                    )
                      ]
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

