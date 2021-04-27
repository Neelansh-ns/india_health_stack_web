import 'dart:html';

import 'package:entities/states.dart';
import 'package:flutter/material.dart';
import 'package:ui/common/pill_button.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:ui/services/navigation/routes.dart';
import 'package:entities/hospital_entity.dart';


class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final DashboardView _view = ViewFactory().get<DashboardView>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _view.onOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(24.0),
            //   child: SizedBox(
            //     width: 250.0,
            //     child: DefaultTextStyle(
            //       style: TextStyle(
            //         fontSize: 24.0,
            //         fontFamily: 'Canterbury',
            //       ),
            //       child: AnimatedTextKit(
            //         animatedTexts: [
            //           ScaleAnimatedText('Please Wear a Mask'),
            //           ScaleAnimatedText('Sanitize Frequently'),
            //           ScaleAnimatedText('Lets Fight Together !!'),
            //         ],
            //         onTap: () {
            //           print("Tap Event");
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            _getLocationButton(),
            _getSelectStateDropDown(),
            _getCityStateDropDown(),
            _getTitleHeadingBar("What are you looking for?"),
            _getSelectionPills(),
            _getTitleHeadingBar("Beds Availability"),

            _getHospitalDataTabs(),
            
            // _getHospitalDataList(),
          ],
        )),
      ),
    );
  }

  _getDropDownListItems(List<States> stateList) {
    return stateList.map((States value) {
      return DropdownMenuItem<States>(
        value: value,
        child: new Text(value.name),
      );
    }).toList();
  }

  _getDropDownCityListItems(List<Cities> stateList) {
    return stateList.map((Cities value) {
      return DropdownMenuItem<Cities>(
        value: value,
        child: new Text(value.name),
      );
    }).toList();
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text("India Health Stack",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
    );
  }

  _getSelectStateDropDown() {
    return StreamBuilder<List<States>>(
        stream: _view.state.stateList.asBroadcastStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 18.0,right: 24,left: 24),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color:Color(0xFF6200EE))),
                padding: EdgeInsets.all(4),
                child: DropdownButton<States>(
                  underline: SizedBox(),
                  value: _view.state.selectedState,
                  hint: Text("Select State"),
                  items: _getDropDownListItems(snapshot.data),
                  onChanged: (value) {
                    _view.selectedState(value);
                    setState(() {
                      _selectedText = value.name;
                    });
                  },
                ),
              ),
            );
          } else {
            return DropdownMenuItem<String>(
              value: "Select State",
              child: new Text("Select State"),
            );
          }
        });
  }

  _getCityStateDropDown() {
    return StreamBuilder<List<Cities>>(
        stream: _view.state.cityList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 24.0,right: 24,left: 24),
              child: Container(
                width: MediaQuery.of(context).size.width - 24,
                padding: EdgeInsets.all(8),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Color(0xFF6200EE))),
                child: DropdownButton<Cities>(
                  underline: SizedBox(),
                  value: _view.state.selectedCity,
                  hint: Text("Select City"),
                  items: _getDropDownCityListItems(snapshot.data),
                  onChanged: (value) {
                    _view.selectedCity(value);
                    setState(() {
                      _selectedText = value.name;
                    });
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  _getTitleHeadingBar(String title) {
    return Padding(
      padding: const EdgeInsets.only(top:28.0,bottom: 14,left: 24),
      child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16,
          fontWeight: FontWeight.w500),),
    );
    
  }

  _getSelectionPills() {
    return Padding(
      padding: const EdgeInsets.only(right:24.0,left: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PillButton(buttonText: "Oxygen Beds",onPressed: (){


              },),
              PillButton(buttonText: "Oxygen Beds 2",onPressed: (){


              },),

              PillButton(buttonText: "Oxygen Beds 3",onPressed: (){


              },),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:14.0),
                child: PillButton(buttonText: "All Beds",isActive:true,onPressed: (){


                },),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getHospitalDataTabs() {
    return Padding(
      padding: const EdgeInsets.only(right:24.0,left: 24),
      child: Column(
        children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 140,
                width: (MediaQuery.of(context).size.width -60)/2,
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Max Super Speciality Hospital, Patparganj",
                      style:TextStyle(fontWeight: FontWeight.w400,fontSize: 12,
                          color: Colors.white,height: 1.5) ,),
                    SizedBox(height: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                        SizedBox(height: 8,),
                        Text("Non oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.0) ,),
                        SizedBox(height: 8,),
                        Text("ICU Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                      ],
                    ),

                  ],

                ),
                decoration: BoxDecoration(
                  color:Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color:Colors.black.withOpacity(0.20)),

                ),
              ),
              Container(
                height: 140,
                width: (MediaQuery.of(context).size.width -60)/2,
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Max Super Speciality Hospital, Patparganj",
                      style:TextStyle(fontWeight: FontWeight.w400,fontSize: 12,
                          color: Colors.white,height: 1.5) ,),
                    SizedBox(height: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                        SizedBox(height: 8,),
                        Text("Non oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.0) ,),
                        SizedBox(height: 8,),
                        Text("ICU Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                      ],
                    ),

                  ],

                ),
                decoration: BoxDecoration(
                  color:Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color:Colors.black.withOpacity(0.20)),

                ),
              ),
            ],
          ),
          SizedBox(height:24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 140,
                width: (MediaQuery.of(context).size.width -60)/2,
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Max Super Speciality Hospital, Patparganj",
                      style:TextStyle(fontWeight: FontWeight.w400,fontSize: 12,
                          color: Colors.white,height: 1.5) ,),
                    SizedBox(height: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                        SizedBox(height: 8,),
                        Text("Non oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.0) ,),
                        SizedBox(height: 8,),
                        Text("ICU Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                      ],
                    ),

                  ],

                ),
                decoration: BoxDecoration(
                  color:Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color:Colors.black.withOpacity(0.20)),

                ),
              ),

              Container(
                height: 140,
                width: (MediaQuery.of(context).size.width -60)/2,
                padding: EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Max Super Speciality Hospital, Patparganj",
                      style:TextStyle(fontWeight: FontWeight.w400,fontSize: 12,
                          color: Colors.white,height: 1.5) ,),
                    SizedBox(height: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                        SizedBox(height: 8,),
                        Text("Non oxygen Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.0) ,),
                        SizedBox(height: 8,),
                        Text("ICU Beds - 5",
                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                              color: Colors.white,height: 1.5) ,),
                      ],
                    ),

                  ],

                ),
                decoration: BoxDecoration(
                  color:Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(2.0),
                  border: Border.all(color:Colors.black.withOpacity(0.20)),

                ),
              ),
            ],
          )

        ],
      ),
    );
  }

  _getLocationButton() {
    return Padding(
      padding: const EdgeInsets.only(right:24.0,left: 24,top: 18),
      child: Row(
        children: [
          Icon(Icons.gps_fixed_sharp,color: Color(0xFF6200EE),),
          SizedBox(width: 12,),
          Text("Use current location",style: TextStyle(color:Color(0xFF6200EE),fontSize: 14 ),)

        ],
      ),
    );
    
  }

// _getHospitalDataList() {
//   return StreamBuilder<List<HospitalEntity>>(
//       stream: _view.state.hospitalData.asBroadcastStream(),
//       builder: (context, AsyncSnapshot<List<HospitalEntity>> snapshot) {
//         if (snapshot.hasData) {
//           return Container(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7.0),
//                       border: Border.all(color: Colors.blueGrey)),
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Hospital Name"),
//                       Text("Total Beds"),
//                       Text("Available Beds"),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 200,
//                   child: ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(snapshot.data[index].hospitalName),
//                             Text(snapshot.data[index].resourcesList.first.countAvailable.toString()),
//                             Text(snapshot.data[index].resourcesList.last.countAvailable.toString()),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Padding(
//             padding: const EdgeInsets.only(top:48.0,right: 24,left: 24),
//             //https://i.ibb.co/nmgXrZj/Pngtree-hand-drawn-protective-doctor-5325151.png
//             //https://i.ibb.co/SXZXVms/Pngtree-hand-drawn-protective-disinfection-5341263.png
//             child: Image.network("https://i.ibb.co/nmgXrZj/Pngtree-hand-drawn-protective-doctor-5325151.png"),
//           );
//         }
//       });
// }
}
