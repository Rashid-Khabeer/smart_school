import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/student-profile_model.dart';
import 'package:smart_school/src/data/models/transport_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/transport-bottom_sheet.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class TransportPage extends StatefulWidget {
  @override
  _TransportPAgeState createState() => _TransportPAgeState();
}

class _TransportPAgeState extends State<TransportPage> {
  bool _isLoading = true;
  List<Transport> _transport = [];

  _getData() async {
    ServerError _error;
    _transport = await RestService()
        .getTransport(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: StudentRequest(
        id: AppData().readLastUser().studentRecord.studentId,
      ),
    )
        .catchError((error) {
      print(error);
      _error = ServerError.withError(error);
      print(_error.errorMessage);
      Toast.show(_error.errorMessage, context);
      _isLoading = true;
    });
    setState(() {});
    _isLoading = false;
  }

  Future<void> _fetchData() async => await _getData();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Route'),
      ),
      body: _isLoading
          ? LoadingWidget()
          : RefreshIndicator(
              onRefresh: _fetchData,
              child: _transport?.isEmpty ?? true
                  ? NoDataWidget()
                  : ListView.builder(
                      itemCount: _transport?.length ?? 0,
                      itemBuilder: (context, index) => _RowItem(
                        transport: _transport[index],
                      ),
                    ),
            ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final Transport transport;

  _RowItem({this.transport});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: Icon(CupertinoIcons.map_pin_ellipse),
                ),
                Text(transport.routeTitle, style: k16BoldStyle),
              ],
            ),
          ),
          transport.vehicles.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: transport.vehicles.length,
                  itemBuilder: (ctx, index) => _SubRowItem(
                    vehicles: transport.vehicles[index],
                  ),
                )
              : NoDataWidget(),
          // _SubRowItem(),
          // _SubRowItem(),
          // _SubRowItem(isAssigned: true),
        ],
      ),
    );
  }
}

class _SubRowItem extends StatelessWidget {
  final TransportVehicles vehicles;

  _SubRowItem({this.vehicles});

  @override
  Widget build(BuildContext context) {
    bool isAssigned = vehicles.assigned == 'yes';
    print(vehicles.vehicleNo);
    print(vehicles.id);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(CupertinoIcons.bus),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 15.0),
            child: Text(vehicles.vehicleNo),
          ),
          if (isAssigned) Text('Assigned', style: kBlueStyle),
          if (isAssigned) Spacer(),
          if (isAssigned)
            TextButton.icon(
              onPressed: () {
                Scaffold.of(context).showBottomSheet(
                  (context) => TransportBottomSheet(
                    vehicle: vehicles,
                  ),
                );
              },
              icon: Icon(CupertinoIcons.square_favorites),
              label: Text('View'),
            ),
          if (!isAssigned) Spacer(),
        ],
      ),
    );
  }
}
