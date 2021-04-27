import 'package:flutter/material.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/navigation/navigation_service.dart';
import 'package:ui/navigation/service_locator.dart';
import 'package:ui/screens/details_page/details_page_view.dart';




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
    print("Roope ${widget.uniqueID}");
  _view.onOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.uniqueID.toString()),
    );
  }
}
