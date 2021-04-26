import 'package:entities/states.dart';
import 'package:flutter/material.dart';
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
      body: Center(
          child: Column(
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
          _getSelectStateDropDown(),
          _getCityStateDropDown(),
          // _getHospitalDataList(),
        ],
      )),
    );
  }

  _getDropDownListItems(List<String> stateList) {
    return stateList.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();
  }

  _getAppBar() {
    return AppBar(
      title: Text("Health Stack"),
      leading: GestureDetector(
        onTap: () {
          /* Write listener code here */
        },
        child: Icon(
          Icons.menu, // add custom icons also
        ),
      ),
    );
  }

  _getSelectStateDropDown() {
    return StreamBuilder<List<States>>(
        stream: _view.state.stateList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                padding: EdgeInsets.all(8),
                child: DropdownButton<States>(
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
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                child: DropdownButton<String>(
                  value: _view.state.selectedCity,
                  hint: Text("Select City"),
                  items: _getDropDownListItems(snapshot.data),
                  onChanged: (value) {
                    _view.selectedCity(value);
                    setState(() {
                      _selectedText = value;
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
