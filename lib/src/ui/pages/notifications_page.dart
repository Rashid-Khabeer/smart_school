import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/notification_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/home-work-bottom_sheet.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = true;
  Notifications _notifications = Notifications();

  _getData() async {
    ServerError _error;
    _notifications = await RestService()
        .getNotifications(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: NotificationRequest(),
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
    return LocalizedView(
      builder: (ctx, lang) => Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _notifications?.data?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _notifications?.data?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _notifications.data[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final NotificationData data;

  _RowItem({this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).showBottomSheet(
          (context) => HomeWorkBottomSheet(
            detail: data.message,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(data.title, style: k16BoldStyle),
                ),
                Text(data.date, style: k14SimpleStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
