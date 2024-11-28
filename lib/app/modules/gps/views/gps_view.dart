import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gps_controller.dart';

class GpsView extends GetView<GpsController> {
  GpsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS View'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: controller.getCurrentLocation,
        //   ),
        // ],
      ),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Titik Koordinat',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(controller.locationMessage.value),
                const SizedBox(height: 20),
                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: controller.getCurrentLocation,
                        child: const Text('Cari Lokasi'),
                      ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.openGoogleMaps,
                  child: const Text('Buka Google Maps'),
                ),
              ],
            )),
      ),
    );
  }
}
