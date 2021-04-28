import 'package:entities/hospital_entity.dart';
import 'package:flutter/material.dart';
import 'package:ui/common/primary_button.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/screens/details_page/details_page_view.dart';
import 'package:ui/services/navigation/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPageWidget extends StatefulWidget {
  String uniqueID;

  DetailsPageWidget(this.uniqueID);

  @override
  _DetailsPageWidgetState createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {
  final DetailsPageView _view = ViewFactory().get<DetailsPageView>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    _view.onOpen(widget.uniqueID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _navigationService.navigateTo(Routes.EntryRouteWidget);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<HospitalEntity>(
          stream: _view.state.hospitalData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(snapshot.data.lastUpdatedTimestamp);
              int differenceTime = DateTime.now().difference(dateTime).inHours;
               String updatedTimeText;
              if(differenceTime == 0){
                updatedTimeText ="Updated - ${differenceTime.toString()} Minutes ago" ;
              }else{
                updatedTimeText = "Updated - ${differenceTime.toString()} Hours ago";
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          updatedTimeText,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 26.0, right: 16, left: 16),
                        child: Text(snapshot.data.hospitalName,
                            style:
                                TextStyle(fontSize: 20, fontWeight: FontWeight.w800, height: 1.5),
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                          child: Column(
                            children: _getDetailRowList(snapshot.data.resourcesList),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Text(
                          "Pincode - ${snapshot.data.pinCode.toString()}",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: GestureDetector(
                          onTap: () {
                            launch("tel://${snapshot.data.phoneNumber}");
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Phone Number - ${snapshot.data.phoneNumber.toString()}",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.call,size: 20.0,color: Color(0xFF6200EE),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: GestureDetector(
                          onTap: () {
                            launch(snapshot.data.mapLink);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "GPS Location ",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.assistant_navigation,size: 20.0,color: Color(0xFF6200EE),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 24),
                      child: PrimaryButton(
                        onPressed: () {
                          _navigationService.replaceCompleteRoute(Routes.EntryRouteWidget);
                        },
                        buttonText: "See Availability near by hospitals",
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _getDetailRowList(List<Resource> resourcesList) {
    return resourcesList.map((e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.network(e.resIcon),
              SizedBox(
                width: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(e.resourceName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 2.0),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          Text(
            e.countAvailable.toString(),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }).toList();
  }
}
