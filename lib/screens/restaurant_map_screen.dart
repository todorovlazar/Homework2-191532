import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantMapScreen extends StatefulWidget {
  @override
  _RestaurantMapScreenState createState() => _RestaurantMapScreenState();
}

class _RestaurantMapScreenState extends State<RestaurantMapScreen> {
  GoogleMapController? _controller;

  
  final List<Marker> _markers = [
  const Marker(
    markerId: MarkerId('1'),
    position: LatLng(37.7749, -122.4194), 
    infoWindow: InfoWindow(title: 'Restaurant 1'),
  ),
  const Marker(
    markerId: MarkerId('2'),
    position: LatLng(37.8049, -122.4312), 
    infoWindow: InfoWindow(title: 'Restaurant 2'),
  ),
  const Marker(
    markerId: MarkerId('3'),
    position: LatLng(37.7750, -122.4195), 
    infoWindow: InfoWindow(title: 'Restaurant 3'),
  ),
  const Marker(
    markerId: MarkerId('4'),
    position: LatLng(37.7751, -122.4196), 
    infoWindow: InfoWindow(title: 'Restaurant 4'),
  ),
  const Marker(
    markerId: MarkerId('5'),
    position: LatLng(37.8048, -122.4311), 
    infoWindow: InfoWindow(title: 'Restaurant 5'),
  ),
  const Marker(
    markerId: MarkerId('6'),
    position: LatLng(37.8047, -122.4310), 
    infoWindow: InfoWindow(title: 'Restaurant 6'),
  ),
  const Marker(
    markerId: MarkerId('7'),
    position: LatLng(37.7752, -122.4197), 
    infoWindow: InfoWindow(title: 'Restaurant 7'),
  ),
  const Marker(
    markerId: MarkerId('8'),
    position: LatLng(37.8046, -122.4309), 
    infoWindow: InfoWindow(title: 'Restaurant 8'),
  ),
  const Marker(
    markerId: MarkerId('9'),
    position: LatLng(37.7753, -122.4198), 
    infoWindow: InfoWindow(title: 'Restaurant 9'),
  ),
  const Marker(
    markerId: MarkerId('10'),
    position: LatLng(37.8045, -122.4308), 
    infoWindow: InfoWindow(title: 'Restaurant 10'),
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of Restaurants'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), 
          zoom: 13.0, 
        ),
        markers: _markers.toSet(),
      ),
    );
  }
}
