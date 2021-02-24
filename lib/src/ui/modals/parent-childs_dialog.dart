import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/data/models/sign-in_model.dart';
import 'package:smart_school/src/utility/constants.dart';

class ParentChildBottomSheet extends StatelessWidget {
  final List<ParentChild> list;
  final Function(bool, int) onSubmitted;

  ParentChildBottomSheet({this.onSubmitted, this.list});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.clear),
                    onPressed: () {
                      onSubmitted(false, 0);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              final data = list[index];
              return InkWell(
                onTap: () => onSubmitted(true, index),
                child: Card(
                  child: ListTile(
                    leading: data?.image?.isEmpty ?? true
                        ? Container()
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: ClipOval(
                              child:
                                  Image.network(kDomainUrl + '/' + data.image),
                            ),
                          ),
                    title: Text(
                      data.name,
                      style: k16BoldStyle,
                    ),
                    subtitle: Text(
                      data.className + ' - ' + data.section,
                      style: k14Style,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
