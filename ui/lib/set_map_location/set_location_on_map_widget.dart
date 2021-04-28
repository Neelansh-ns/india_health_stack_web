import 'package:entities/lat_lng.dart';
import 'package:flutter/material.dart';
import 'package:ui/common/primary_button.dart';
import 'package:ui/factory/view_model/india_health_stack_view_factory.dart';
import 'package:ui/map/india_health_stack_map_view.dart';
import 'package:ui/map/map_new.dart';
import 'package:ui/map/polygon_lat_lng.dart.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/set_map_location/set_location_map_view.dart';

class SetLocationOnMapWeb extends StatefulWidget {
  final List<List<LatLng>> polygonLatLng;

  SetLocationOnMapWeb(this.polygonLatLng);

  @override
  _SetLocationOnMapWebState createState() => _SetLocationOnMapWebState();
}

class _SetLocationOnMapWebState extends State<SetLocationOnMapWeb> {
  final SetLocationOnMapView _setLocationOnMapView =
      ViewFactory().get<SetLocationOnMapView>();
  final IndiaHealthStackMapView _indiaHealthStackMapView =
      ViewFactory().get<IndiaHealthStackMapView>();
  final NavigationService _navigationService = locator<NavigationService>();

  get pin => IgnorePointer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_pin,
                size: 32,
              ),
//              Icon(Icons.place, size: 56),
              Container(
                decoration: ShapeDecoration(
                  shadows: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black38,
                    ),
                  ],
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 4,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _setLocationOnMapView.refreshAllStates();
    print('inside map init ${widget.polygonLatLng}');
    _setLocationOnMapView
        .onOpen(widget.polygonLatLng ?? PolygonLatLng.BANGALORE);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapNewWidget(),
        Stack(
          children: [
            Column(
              children: [
                topWidget,
                StreamBuilder<bool>(
                  stream: _setLocationOnMapView.state.isUnderServiceableArea,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && !snapshot.data) {
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: pin,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder<bool>(
                stream: _setLocationOnMapView.state.isButtonActivated,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _indiaHealthStackMapView.moveToCurrentLocation();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                              child: Icon(
                            Icons.my_location,
                            color: Colors.black,
                            size: 20,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      PrimaryButton(
                        cornerRadius: 4,
                        isActive: snapshot.data ?? false,
                        buttonText: 'SET DESTINATION',
                        onPressed: () {
                          _navigationService.goBack(result: [
                            _setLocationOnMapView.state.presentLatLng,
                            _setLocationOnMapView.state.currentAddressValue
                          ]);
                        },
                      ),
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget get topWidget => Material(
        elevation: 10,
        color: Colors.white,
        shadowColor: Colors.grey[100],
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: _backArrow,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 24,
                        width: 24,
                        alignment: Alignment.center,
                        child: Container(
                          height: 8,
                          width: 8,
                          color: Color(0xff15D48F),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: StreamBuilder<String>(
                            stream: _setLocationOnMapView.state.currentAddress,
                            builder: (context, snapshot) {
                              print('heyeeee ${snapshot.data}');
                              return Text(
                                '${snapshot.data ?? ''}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                    color: Colors.grey,
                                    fontSize: 14),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  get _backArrow => GestureDetector(
        onTap: () {
          _navigationService.goBack();
        },
        child: Icon(Icons.arrow_back),
      );

// Widget get cautionWidget => Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         border: Border.all(color: BColors.yellowOrangeBorder),
//         color: BColors.yellowLemon.withOpacity(0.5),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Icon(
//             Icons.do_not_disturb,
//             color: BColors.orangeYellow,
//           ),
//           horizontalSpace(12),
//           Expanded(
//             child: Text(
//               'Don\'t take scooters outside the service area',
//               style: regular.size14.greyishBrown,
//             ),
//           ),
//         ],
//       ),
//     );
}
