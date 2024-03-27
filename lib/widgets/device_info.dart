import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/station_service.dart';

class DeviceInfo extends StatelessWidget {
  final RxBool isInfoShowing = false.obs ;

  DeviceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ObxValue<RxBool>((value) {
        if (value.value) {
          return FutureBuilder<bool>(
              future: InternetConnectionChecker().hasConnection,
              builder: (context, snapshot) {
                var currentStation = StationService.to.currentStation;
                return Container(
                  color: Colors.lightGreen.withOpacity(0.4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon((snapshot.data == true ? Icons.wifi : Icons.wifi_off)),
                      Text("ID: ${currentStation.id}"),
                      Text("NAME: ${currentStation.attributes?.name}"),
                      Text("SERIAL: ${currentStation.attributes?.tabletSerial}"),
                      TextButton(
                          onPressed: () {
                            debugPrint("hide");
                            value.value = false;
                          },
                          child: const Text("Hide"))
                    ],
                  ),
                );
              });
        }

        return RawGestureDetector(
            gestures: {
              SerialTapGestureRecognizer:
              GestureRecognizerFactoryWithHandlers<
                  SerialTapGestureRecognizer>(
                  SerialTapGestureRecognizer.new,
                      (SerialTapGestureRecognizer instance) {
                    instance.onSerialTapDown =
                        (SerialTapDownDetails details) {
                      if (details.count == 5) {
                        isInfoShowing.value = true;
                      }
                    };
                  })
            }
        );
      }, isInfoShowing),
    );
  }
}
