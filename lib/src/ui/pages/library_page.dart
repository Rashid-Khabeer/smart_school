import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/library_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/pages/library-books_page.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smart_school/src/utility/nav.dart';
import 'package:toast/toast.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool _isLoading = true;
  List<LibraryIssued> _issued = [];
  LibraryIssuedResult _result = LibraryIssuedResult();

  _getData() async {
    ServerError _error;
    final _restResponse = await RestService()
        .getIssuedBooks(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
      request: LibraryRequest(
        studentId: AppData().getUserId(),
      ),
    )
        .catchError((error) {
      print(error);
      Toast.show(error, context);
      _isLoading = true;
    });
    if (_error == null) {
      try {
        _result = LibraryIssuedResult.fromJson(_restResponse);
      } catch (_) {
        _restResponse.forEach((e) => _issued.add(LibraryIssued.fromJson(e)));
      }
    }
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
          title: Text(lang.library),
          actions: [
            TextButton.icon(
              onPressed: () => AppNavigation.to(
                context,
                LibraryBooksPage(),
              ),
              icon: Icon(
                FontAwesome.book,
                color: Colors.white,
              ),
              label: Text(
                lang.books,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _issued?.isEmpty ?? true
                    ? NoDataWidget(
                        message: _result?.errorMsg ?? '${lang.noData}',
                      )
                    : ListView.builder(
                        itemCount: _issued?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          data: _issued[index],
                          lang: lang,
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final AppLocalizations lang;
  final LibraryIssued data;

  _RowItem({this.data, this.lang});

  @override
  Widget build(BuildContext context) {
    var _color = Colors.red;
    var _text = lang.notReturned;
    if ((data?.isReturned ?? '') == '1') {
      _color = Colors.green;
      _text = lang.returned;
    }
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey.shade300,
            child: Row(
              children: [
                Icon(FontAwesome.book),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data?.bookTitle ?? 'Title'}',
                          style: k16BoldStyle,
                        ),
                        Text(
                          '${data?.author ?? 'Author'}',
                          style: k14Style,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.calendar),
                SizedBox(width: 5.0),
                Text(
                  '${lang.issuedDate}\n${data?.issueDate ?? 'Date'}',
                  style: k14Style,
                ),
                Spacer(),
                Icon(FontAwesome.book),
                SizedBox(width: 5.0),
                Text(
                  '${lang.bookNo}\n${data?.bookNo ?? ''}',
                  style: k14Style,
                ),
                Spacer(),
                Icon(CupertinoIcons.calendar),
                SizedBox(width: 5.0),
                Text(
                  '${lang.dueReturnDate}\n${data?.dueReturnDate ?? 'Date'}',
                  style: k14Style,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.calendar),
                SizedBox(width: 5.0),
                Text(
                  '${lang.returnDate}\n${data?.returnDate ?? ''}',
                  style: k14Style,
                ),
                Spacer(),
                Icon(FontAwesome.book),
                SizedBox(width: 5.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.status,
                      style: k14Style,
                    ),
                    Container(
                      child: Text(
                        _text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      color: _color,
                      padding: EdgeInsets.all(5.0),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
