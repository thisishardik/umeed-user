import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  List<Address> myLocation;
  Address myLocalityAddress;

  Future<List<Address>> getMyCurrentLocation() async {
    try {
      // Position position = await Geolocator.getCurrentPosition();
      Position pos = await GeolocatorPlatform.instance.getCurrentPosition();
      latitude = pos.latitude;
      longitude = pos.longitude;

      myLocation = await Geocoder.local
          .findAddressesFromCoordinates(Coordinates(latitude, longitude));
      print(myLocation.first);
      return myLocation;
    } catch (e) {
      print("Error in fetching location is $e");
    }
  }
}
