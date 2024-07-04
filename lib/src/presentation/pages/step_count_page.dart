import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthcare_app/src/router/router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pedometer/pedometer.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepCountPage extends StatefulWidget {
  const StepCountPage({super.key});

  @override
  State<StatefulWidget> createState() => _StepCountPageState();
}

class _StepCountPageState extends State<StepCountPage>
    with TickerProviderStateMixin {
  MapboxMapController? mapController;
  StreamSubscription<StepCount>? _stepCountSubscription;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusSubscription;
  String _status = '?', _steps = '0';
  bool isTracking = false;
  final List<LatLng> _routePoints = [];
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  double _distance = 0.0;
  LatLng _currentLocation = const LatLng(10.893309, 106.791911);
  Line? _routeLine;
  String initStep = '0';

  // Hàm này xử lý cho map
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  Future<void> getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final LocationData currentLocationData = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
    });
  }

  // Những hàm này xử lý cho đếm bước chân
  @override
  void initState() {
    super.initState();
    // initPlatformState();
    getCurrentLocation();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
      if (initStep == '0'){
        initStep = _steps;
      }
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  // void initPlatformState() {
  //   _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //   _stepCountStream = Pedometer.stepCountStream;
  //
  //   _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //   _stepCountStream = Pedometer.stepCountStream;
  //
  //   if (!mounted) return;
  // }

  void initPlatformState() {
    _pedestrianStatusSubscription =
        Pedometer.pedestrianStatusStream.listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);
    _stepCountSubscription =
        Pedometer.stepCountStream.listen(onStepCount, onError: onStepCountError);
    // initStep = _steps;
    if (!mounted) return;
  }

  Future<void> _startTracking() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _routePoints.clear();
    _distance = 0.0;

    // _pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    //     .onError(onPedestrianStatusError);
    //
    // _stepCountStream.listen(onStepCount).onError(onStepCountError);
    initPlatformState();
    if (mapController != null) {
      _routeLine = await mapController!.addLine(
        LineOptions(
          geometry: _routePoints,
          lineColor: '#ff0000',
          lineWidth: 5.0,
        ),
      );
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (!isTracking) return;
      setState(() {
        LatLng currentPoint =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        if (_routePoints.isNotEmpty) {
          _distance += _calculateDistance(_routePoints.last, currentPoint);
        }
        _routePoints.add(currentPoint);
        mapController!.updateLine(
          _routeLine!,
          LineOptions(
            geometry: _routePoints,
          ),
        );
        mapController?.animateCamera(
          CameraUpdate.newLatLng(currentPoint),
        );
      });
    });
  }

  void _stopTracking() {
    // if (mapController != null && _routePoints.isNotEmpty) {
    //   mapController!.addLine(
    //     LineOptions(
    //       geometry: _routePoints,
    //       lineColor: '#ff0000',
    //       lineWidth: 5.0,
    //     ),
    //   );
    // }
    setState(() {
      isTracking = false;
      _routePoints.clear();
    });
    _stepCountSubscription?.cancel();
    _pedestrianStatusSubscription?.cancel();
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double R = 6371000; // Radius of the Earth in meters
    double lat1 = start.latitude * (3.141592653589793 / 180);
    double lon1 = start.longitude * (3.141592653589793 / 180);
    double lat2 = end.latitude * (3.141592653589793 / 180);
    double lon2 = end.longitude * (3.141592653589793 / 180);
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;
    double a = (sin(dlat / 2) * sin(dlat / 2)) +
        cos(lat1) * cos(lat2) * (sin(dlon / 2) * sin(dlon / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c;
    return distance / 1000; // Return distance in kilometers
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: const Color(0xfffbedec),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (RouterCustom.router.canPop()) {
                              RouterCustom.router.pop();
                            }
                          },
                          child: Image.asset('res/images/go-back.png'),
                        ),
                        Text(
                          "walking".toUpperCase(),
                          style: TextStyle(
                            color: HexColor("474672"),
                            fontFamily: "SourceSans3",
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                               print("heheh");
                              },
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                    fontFamily: "SourceSans3",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: MapboxMap(
                      accessToken:
                          "sk.eyJ1IjoibWFpYmFveHQxIiwiYSI6ImNseTBobGF4MTBkb3gybHBkcGEzYnZkMXgifQ.2RNaTFivfgQayZJ-JgIzYg",
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation,
                        zoom: 14.0,
                      ),
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 22),
                      zoomGesturesEnabled: true,
                      // myLocationEnabled: true,
                      // myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
                      // myLocationRenderMode: MyLocationRenderMode.NORMAL,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xFFF18872)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Text(
                                "Distance".toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${_distance.toStringAsFixed(2)} km",
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: const Color(0xFFF18872)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              "step".toUpperCase(),
                              style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${(int.parse(_steps)-int.parse(initStep)).toString()} steps",
                              style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xFFF18872)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Text(
                                "Calories".toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _steps.isNotEmpty
                                    ? "${((int.parse(_steps)-int.parse(initStep)) * 0.04).toStringAsFixed(2)} kcal"
                                    : '0 kcal',
                                style: const TextStyle(
                                  fontFamily: "SourceSans3",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: const Color(0xFFF18872)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              "status".toUpperCase(),
                              style: const TextStyle(
                                fontFamily: "SourceSans3",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _status,
                              style: _status == 'walking'
                                  ? const TextStyle(fontSize: 20)
                                  : const TextStyle(
                                      fontSize: 20, color: Colors.red),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isTracking = !isTracking;
                        });
                        if (isTracking) {
                          _startTracking();
                          print("Đang theo dõi");
                        } else {
                          _stopTracking();
                          print("Đang dừng theo dõi");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTracking
                            ? const Color(0xFFF18872)
                            : const Color(0xFF474672),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        isTracking
                            ? "End".toUpperCase()
                            : "Start".toUpperCase(),
                        style: const TextStyle(
                          fontFamily: "SourceSans3",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
