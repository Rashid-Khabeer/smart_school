import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/tasks_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/modals/add-task_dialog.dart';
import 'package:smart_school/src/ui/modals/confirmation_dialog.dart';
import 'package:smart_school/src/ui/modals/loading_dialog.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool _isLoading = true;
  Tasks _tasks = Tasks();

  _getData() async {
    ServerError _error;
    _tasks = await RestService()
        .getTasks(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: TasksRequest(userId: AppData().readLastUser().userId),
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
          title: Text(lang.task),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _tasks?.tasks?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _tasks?.tasks?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _tasks.tasks[index],
                          lang: lang,
                          onChanged: () {
                            _isLoading = true;
                            setState(() {});
                            _getData();
                          },
                        ),
                      ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await openAddTaskDialog(context: context);
            _isLoading = true;
            setState(() {});
            _getData();
          },
          child: Icon(CupertinoIcons.add),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _RowItem extends StatelessWidget {
  final TasksData data;
  final Function onChanged;
  final AppLocalizations lang;

  _RowItem({this.data, this.onChanged, this.lang});

  var _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Slidable(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(CupertinoIcons.list_number),
              ),
              Text(
                '${data.title}\n${data.startDate}',
                style: k16BoldStyle,
              ),
              Spacer(),
              Checkbox(
                onChanged: _onChanged,
                value: data.isActive == 'yes',
              ),
            ],
          ),
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: lang.delete,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            if ((await openConfirmationDialog(
              title: lang.confirm,
              content: lang.deleteTask,
              context: context,
            ))) _delete();
          },
        ),
      ],
    );
  }

  _delete() async {
    openLoadingDialog(context: _context);
    final _response = await RestService()
        .deleteTask(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: DeleteTask(
        id: data.id,
      ),
    )
        .catchError((error) {
      print(error);
      Toast.show(ServerError.withError(error).errorMessage, _context);
    });
    if (_response != null) {
      Toast.show(_response.msg, _context);
    }
    Navigator.of(_context).pop();
    onChanged();
  }

  _onChanged(value) async {
    final _status = value ? 'yes' : 'no';
    openLoadingDialog(context: _context);
    final _response = await RestService()
        .updateTask(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: UpdateTask(
        id: data.id,
        status: _status,
      ),
    )
        .catchError((error) {
      print(error);
      Toast.show(ServerError.withError(error).errorMessage, _context);
    });
    if (_response != null) {
      Toast.show(_response.msg, _context);
    }
    Navigator.of(_context).pop();
    onChanged();
  }
}
