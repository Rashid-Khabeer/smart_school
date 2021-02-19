import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/library_model.dart';
import 'package:smart_school/src/l10n/app_localizations.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/list-view_widgets.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:toast/toast.dart';

class LibraryBooksPage extends StatefulWidget {
  @override
  _LibraryBooksPageState createState() => _LibraryBooksPageState();
}

class _LibraryBooksPageState extends State<LibraryBooksPage> {
  bool _isLoading = true;
  LibraryBooks _books = LibraryBooks();

  _getData() async {
    ServerError _error;
    _books = await RestService()
        .getBooks(
      authKey: AppData().readLastUser().token,
      userId: AppData().readLastUser().userId,
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
          title: Text(lang.books),
        ),
        body: _isLoading
            ? LoadingWidget()
            : RefreshIndicator(
                onRefresh: _fetchData,
                child: _books?.data?.isEmpty ?? true
                    ? NoDataWidget()
                    : ListView.builder(
                        itemCount: _books?.data?.length ?? 0,
                        itemBuilder: (context, index) => _RowItem(
                          lang: lang,
                          data: _books.data[index],
                        ),
                      ),
              ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final LibraryBooksData data;
  final AppLocalizations lang;

  _RowItem({this.data, this.lang});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.book),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.bookTitle, style: k16BoldStyle),
                    SizedBox(height: 3),
                    Text(
                      '${lang.author}:  ${data.author}\t\t\t\t\t${lang.publisher}:  ${data.publish}',
                      style: k14Style,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 10.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.book),
                SizedBox(width: 5.0),
                Text(
                  '${lang.subject}\n${data.subject}',
                  style: k14Style,
                ),
                Spacer(),
                Icon(CupertinoIcons.calendar),
                SizedBox(width: 5.0),
                Text(
                  '${lang.addedOn}\n${data.postDate}',
                  style: k14Style,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rack No: ${data.rackNo}',
                  style: k14Style,
                ),
                Text(
                  '${lang.quantity}: ${data.qty}',
                  style: k14Style,
                ),
                Text(
                  '${lang.price}: IDQ ${data.perUnitCost}',
                  style: k14Style,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
