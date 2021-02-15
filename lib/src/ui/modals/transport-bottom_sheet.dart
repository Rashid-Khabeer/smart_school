import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/transport_model.dart';
import 'package:smart_school/src/utility/constants.dart';

class TransportBottomSheet extends StatelessWidget {
  final TransportVehicles vehicle;

  TransportBottomSheet({this.vehicle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(vehicle.vehicleNo, style: k16BoldStyle),
                  Spacer(),
                  IconButton(
                    icon: Icon(CupertinoIcons.clear),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Vehicle No: \t\t${vehicle.vehicleNo}', style: k14Style),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Vehicle Model: \t\t${vehicle.vehicleModel}',
                        style: k14Style),
                  ),
                  Text('Made: \t\t${vehicle.manufacturerYear}',
                      style: k14Style),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Driver Name: \t\t${vehicle.driverName}',
                        style: k14Style),
                  ),
                  Text('Driver License: \t\t${vehicle.driverLicense}',
                      style: k14Style),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Driver Contact: \t\t${vehicle.driverContact}',
                        style: k14Style),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
