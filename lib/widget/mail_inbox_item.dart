import 'package:flutter/material.dart';

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
                const Text("From : ",),
                const SizedBox(
                  width: 10,
                ),
                Text("${widget.inboxItem.from.address}",),
                const SizedBox(
                  width: 10,
                ),
                Text("${widget.inboxItem.from.name}",),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Subject : ${widget.inboxItem.subject}",),

              ],
            ),
            const SizedBox(height: 20,),
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
