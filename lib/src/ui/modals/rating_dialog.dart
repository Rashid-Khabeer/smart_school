import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/data.dart';
import 'package:smart_school/src/data/models/teachers_model.dart';
import 'package:smart_school/src/services/rest/rest_service.dart';
import 'package:smart_school/src/services/server_error.dart';
import 'package:smart_school/src/ui/views/localized_view.dart';
import 'package:smart_school/src/ui/widgets/button_widget.dart';
import 'package:smart_school/src/utility/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

openRatingDialog({
  @required BuildContext context,
  @required String staffId,
}) {
  String rating, comment;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LocalizedView(
      builder: (context, lang) => AlertDialog(
        insetPadding: EdgeInsets.all(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(lang.rating, style: k16BoldStyle),
        actions: [
          AppButtonWidget(
            text: lang.submit,
            onPressed: () async {
              if ((rating?.isEmpty ?? true) || rating == '0.0') {
                Toast.show('Rating is Empty', context);
                return;
              }
              print(rating);
              if (comment?.isEmpty ?? true) {
                Toast.show('Comment is Empty', context);
                return;
              }
              Toast.show('Rating....', context);
              final _response = await RestService()
                  .teacherRate(
                authKey: AppData().readLastUser().token,
                userId: AppData().readLastUser().userId,
                request: TeacherRatingRequest(
                  userId: AppData().readLastUser().userId,
                  comment: comment,
                  rate: rating,
                  role: AppData().readLastUser().studentRecord.role,
                  staffId: staffId,
                ),
              )
                  .catchError((error) {
                print(error);
                Toast.show(ServerError.withError(error).errorMessage, context);
              });
              if (_response != null) {
                Toast.show(_response.msg, context);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Text(lang.addRating),
                SizedBox(width: 5.0),
                SmoothStarRating(
                  starCount: 5,
                  isReadOnly: false,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0,
                  size: 25,
                  onRated: (value) => rating = value.toString(),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(lang.comment),
                SizedBox(width: 5.0),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      onChanged: (value) => comment = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
