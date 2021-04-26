import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:ui/factory/view_model/bounce_ltr_view_factory.dart';
import 'package:ui/map/bounce_map_new_view.dart';
import 'package:ui/map/map_style_guide.dart';

class MapNewWidget extends StatefulWidget {
  @override
  _MapNewWidgetState createState() => _MapNewWidgetState();
}

class _MapNewWidgetState extends State<MapNewWidget> {
  BounceMapNewView _bounceMapNewView = ViewFactory().get<BounceMapNewView>();

  @override
  Widget build(BuildContext context) {
    return getMap();
  }

  Widget getMap() {
    String htmlId = UniqueKey().toString();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final initialLatLng = _bounceMapNewView.state?.userLatLng ?? LatLng(12.916887, 77.598630);

      final mapOptions = MapOptions()
        ..zoom = 15.2
        ..streetViewControl = false
        ..mapTypeControl = false
        ..fullscreenControl = false
        ..keyboardShortcuts = false
        ..clickableIcons = false
        ..zoomControl = false
        ..styles = mapStyle
        ..center = initialLatLng;

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = GMap(elem, mapOptions);

//      final marker = Marker(MarkerOptions()
//        ..position = initialLatLng
//        ..map = map
//        ..title = 'Hello World!');
      _bounceMapNewView.state.serviceAreaSet.forEach((polyGon) {
        polyGon..map = map;
      });

      map
        ..addListener('idle', () {
          var center = map.get('center');
          _bounceMapNewView.mapJsObjectToLatLng(center);
//      print(e.runtimeType);
//      var t= js.context['JSON'].callMethod('stringify',[e]);
//      print(t);
//      print('hey ${e.runtimeType}');
        });
      Stream<dynamic> s = map.onBoundsChanged;
      s.listen((event) {
        _bounceMapNewView.updateCameraTargetOnMove(null);
        _bounceMapNewView.onCameraMove();
      });
      _bounceMapNewView.state.moveToCurrentLocation.listen((shouldMove) {
        if (shouldMove) {
          map..panTo(initialLatLng);
        }
      });

//      final infoWindow = InfoWindow(InfoWindowOptions()
//        ..content = contentString);
//      marker.onClick.listen((MouseEvent event) {
//        print(event);
//        print(event.latLng.lat);
//        infoWindow.open(map, marker);
//      });

      return elem;
    });

    return HtmlElementView(viewType: htmlId,key: UniqueKey(),);
  }
}
