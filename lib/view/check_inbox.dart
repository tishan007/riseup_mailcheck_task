import 'package:flutter/material.dart';
import 'package:riseup_mailcheck_task/models/message.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/widget/mail_inbox_item.dart';

class CheckInbox extends StatefulWidget {
  @override
  _CheckInboxState createState() => _CheckInboxState();
}

class _CheckInboxState extends State<CheckInbox> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Inbox"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: _buildInbox(),
    );
  }

  _buildInbox() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<Message>(
          future: api.getMessage(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:

              case ConnectionState.waiting:
                return const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )),
                );

              case ConnectionState.none:
                return const Center(child: Text("Unable to connect right now"));

              case ConnectionState.done:
                if (snapshot.hasError) {
                  print("Error: ${snapshot.error}");
                  return Text('Error: ${snapshot.error}');
                }

                return (snapshot.data!.hydraMember.isEmpty)
                    ? const Center(
                        child: Text(
                          "You have no inbox message",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.hydraMember.length,
                        separatorBuilder: (context, _) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return MailInboxItem(inboxItem: snapshot.data!.hydraMember[index],);
                        },
                      );
            }
          },
        ),
      ),
    );
  }
}
