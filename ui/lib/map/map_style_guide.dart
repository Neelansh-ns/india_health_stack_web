import 'package:google_maps/google_maps.dart';

List<MapTypeStyle> mapStyle = [
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_LOCALITY
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#917e7e'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_NEIGHBORHOOD
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#917e7e'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE_MAN_MADE
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [MapTypeStyler()..color = '#f3f1f3'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE_MAN_MADE
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [MapTypeStyler()..color = '#dad7d7'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE_MAN_MADE
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#f3f1f3'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_ATTRACTION
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_ATTRACTION
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [
      MapTypeStyler()
        ..color = '#a39f9f'
        ..visibility = 'simplified'
    ],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_ATTRACTION
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_BUSINESS
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#bda9a9'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_GOVERNMENT
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#c7c2c2'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_GOVERNMENT
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#bda9a9'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_MEDICAL
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [
      MapTypeStyler()
        ..color = '#c7c2c2'
        ..visibility = 'off'
    ],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_MEDICAL
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#bda9a9'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PARK
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [MapTypeStyler()..color = '#c6e7b3'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PARK
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#c7c2c2'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PARK
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#99b28b'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PLACE_OF_WORSHIP
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PLACE_OF_WORSHIP
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#a39f9f'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_SCHOOL
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_SCHOOL
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#a39f9f'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_SPORTS_COMPLEX
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_SPORTS_COMPLEX
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..color = '#a39f9f'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_ARTERIAL
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [MapTypeStyler()..color = '#ffffff'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_ARTERIAL
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#867676'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..stylers = [MapTypeStyler()..visibility = 'on'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [MapTypeStyler()..color = '#f3cccc'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [MapTypeStyler()..color = '#c8a8a8'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#867676'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_LOCAL
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [MapTypeStyler()..color = '#ffffff'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_LOCAL
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#867676'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT_LINE
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [MapTypeStyler()..color = '#e0dddd'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT_LINE
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT_STATION
    ..stylers = [MapTypeStyler()..visibility = 'off'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.WATER
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [MapTypeStyler()..color = '#c4d0e6'],
  MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.WATER
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [MapTypeStyler()..color = '#c4d0e6'],
];
