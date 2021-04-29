import 'dart:html';

import 'package:entities/hospital_entity.dart';
import 'package:entities/states.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ui/common/pill_button.dart';
import 'package:ui/factory/view_model/india_health_stack_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/screens/dashboard_view.dart';
import 'package:ui/services/navigation/routes.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final DashboardView _view = ViewFactory().get<DashboardView>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
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
        child: Text(value.name),
      );
    }).toList();
  }

  _getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        "India Health Stack",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
    );
  }

  _getSelectStateDropDown() {
    return StreamBuilder<List<States>>(
        stream: _view.state.stateList.asBroadcastStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 24, left: 24),
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Color(0xFF6200EE))),
                padding: EdgeInsets.all(4),
                child: StreamBuilder<States>(
                    stream: _view.state.selectedState,
                    builder: (context, selectedStateSnapshot) {
                      return DropdownButton<States>(
                        underline: SizedBox(),
                        value: selectedStateSnapshot.data,
                        hint: Text("Select State"),
                        items: _getDropDownListItems(snapshot.data),
                        onChanged: (value) {
                          _view.selectedState(value);
                        },
                      );
                    }),
              ),
            );
          } else {
            return Center(
                child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )));
          }
        });
  }

  _getCityStateDropDown() {
    return StreamBuilder<List<Cities>>(
        stream: _view.state.cityList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 24.0, right: 24, left: 24),
              child: Container(
                width: MediaQuery.of(context).size.width - 24,
                padding: EdgeInsets.all(8),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Color(0xFF6200EE))),
                child: StreamBuilder<Cities>(
                    stream: _view.state.selectedCity,
                    builder: (context, selectedCitySnapshot) {
                      return DropdownButton<Cities>(
                        underline: SizedBox(),
                        value: selectedCitySnapshot.data,
                        hint: Text("Select City"),
                        items: _getDropDownCityListItems(snapshot.data),
                        onChanged: (value) {
                          _view.selectedCity(value);
                          _view.updateLoadingState(true);
                        },
                      );
                    }),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  _getTitleHeadingBar(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, bottom: 14, left: 24),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  _getSelectionPills() {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24),
      child: Column(
        children: [
          StreamBuilder<List<String>>(
              stream: _view.state.refreshPills,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PillButton(
                      buttonText: "Oxygen Beds",
                      onPressed: (value) {
                        _view.sortBeds("bo", value);
                      },
                    ),
                    PillButton(
                      buttonText: "Non Oxygen Beds",
                      onPressed: (value) {
                        _view.sortBeds("bwo", value);
                      },
                    ),
                    PillButton(
                      buttonText: "ICU Beds",
                      onPressed: (value) {
                        _view.sortBeds("icu", value);
                      },
                    ),
                  ],
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: PillButton(
                  buttonText: "All Beds",
                  isActive: _view.state.allBedsFlag,
                  onPressed: (value) {
                    _view.resetAllBedsFlag(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getHospitalDataTabs() {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24),
      child: StreamBuilder<List<HospitalEntity>>(
          stream: _view.state.hospitalData.asBroadcastStream(),
          builder: (context, AsyncSnapshot<List<HospitalEntity>> snapshot) {
            if (snapshot.hasData && snapshot?.data?.first != null) {
              return LayoutBuilder(
                builder: (context, constraints) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (snapshot.data.length / 2).floor(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _navigationService
                                    .navigateTo(Routes.detailsPage, arguments: {
                                  "uniqueID": "${snapshot.data[index].uniqueID}"
                                });
                              },
                              child: Container(
                                height: 240,
                                width: constraints.maxWidth > 1250 ? 600 : 150,
                                // constraints: BoxConstraints(maxWidth: 400,minWidth: 200),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.1))),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data[index].hospitalName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                              height: 1.5),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: _getAvailabilityItems(
                                              snapshot
                                                  .data[index].resourcesList,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (snapshot.data.length % 2 == 0)
                              GestureDetector(
                                onTap: () {
                                  _navigationService.navigateTo(
                                      Routes.detailsPage,
                                      arguments: {
                                        "uniqueID":
                                            "${snapshot.data[index + 1].uniqueID}"
                                      });
                                },
                                child: Container(
                                  height: 240,
                                  width:
                                      constraints.maxWidth > 1250 ? 600 : 150,
                                  // constraints: BoxConstraints(maxWidth: 400,minWidth: 200),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.1))),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot
                                                .data[index + 1].hospitalName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                                height: 1.5),
                                          ),
                                          SizedBox(
                                            height: 18,
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _getAvailabilityItems(
                                                snapshot.data[index + 1]
                                                    .resourcesList,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )),
              );
            } else if (_view.state.selectedStateValue == null) {
              return Padding(
                padding: const EdgeInsets.only(top: 48.0, right: 24, left: 24),
                //https://i.ibb.co/nmgXrZj/Pngtree-hand-drawn-protective-doctor-5325151.png
                //https://i.ibb.co/SXZXVms/Pngtree-hand-drawn-protective-disinfection-5341263.png
                child: Image.network(
                    "https://i.ibb.co/nmgXrZj/Pngtree-hand-drawn-protective-doctor-5325151.png"),
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }

  _getLocationButton() {
    return GestureDetector(
      onTap: () {
        showToast("Location not supported by browser",
            backgroundColor: Colors.grey,
            animationDuration: Duration(milliseconds: 10));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24, top: 18),
        child: Row(
          children: [
            Icon(
              Icons.gps_fixed_sharp,
              color: Color(0xFF6200EE),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Use current location",
              style: TextStyle(color: Color(0xFF6200EE), fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  _getAvailabilityItems(List<Resource> data) {
    return data.map((e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          "${e.resourceName} - ${e.countAvailable}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
              height: 1.5),
        ),
      );
    }).toList();
  }
}
