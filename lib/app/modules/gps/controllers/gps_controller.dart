import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class GpsController extends GetxController {
  Position? _currentPosition;
  var locationMessage = "Mencari Lat dan Long...".obs;
  var isLoading = false.obs;

  Future<void> getCurrentLocation() async {
    isLoading.value = true; 
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      locationMessage.value =
          "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}";
    } catch (e) {
      locationMessage.value = 'Gagal mendapatkan lokasi: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void openGoogleMaps() {
    if (_currentPosition != null) {
      final url =
          'https://www.google.com/maps?q=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      _launchURL(url);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
