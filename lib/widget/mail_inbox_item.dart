import 'package:flutter/material.dart';
import 'package:riseup_mailcheck_task/models/message.dart';

class MailInboxItem extends StatefulWidget {
  var inboxItem;
  MailInboxItem({required this.inboxItem});

  @override
  _MailInboxItemState createState() => _MailInboxItemState();
}

class _MailInboxItemState extends State<MailInboxItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("From : ",),
                SizedBox(
                  width: 10,
                ),
                Text("${widget.inboxItem.from.address}",),
                SizedBox(
                  width: 10,
                ),
                Text("${widget.inboxItem.from.name}",),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Subject : ${widget.inboxItem.subject}",),

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Body : ${widget.inboxItem.intro}",),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
