import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:riseup_mailcheck_task/models/token.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';
import 'package:riseup_mailcheck_task/view/check_inbox.dart';

class SendEmailPage extends StatefulWidget {
  final String username, password;

  SendEmailPage({required this.username, required this.password});

  @override
  _SendEmialPageState createState() => _SendEmialPageState();
}

class _SendEmialPageState extends State<SendEmailPage> {
  Api api = Api();
  bool isToken = false, checkedValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isToken = false;
    Utils.token = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Email"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: _buildMailBody(),
    );
  }

  _buildMailBody() {
    print("isToken : $isToken");
    print("Utils token  : ${Utils.token}");
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  Token response = await api.generateToken(widget.username, widget.password);
                  if (response.token.isNotEmpty) {
                    Utils.successToast("Token generated successfully");
                    Utils.token = response.token;
                    isToken = true;
                  } else {
                    Utils.errorToast("Token not generated");
                  }
                },
                child: const Text("Get Token"),
              ),
              SizedBox(
                height: 50,
              ),
              (!isToken)
                  ? const Text("You need token to send email", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),)
                  : const Text("You can send an email", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                title: const Text(
                  "Do you want to send mail?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                    print("checkedValue : ");
                    print(checkedValue);
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              (checkedValue)
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if(isToken) {
                              _sendMailBody();
                            } else {
                              Utils.errorToast("Token is Needed");
                            }

                          },
                          child: const Text("Send Email"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if(isToken) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return CheckInbox();
                                },
                              ));
                            } else {
                              Utils.errorToast("Token is Needed");
                            }
                          },
                          child: const Text("Check inbox"),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Future<void> _sendMailBody() async {
    final Email email = Email(
      body: 'Good Day',
      subject: 'Assignment',
      recipients: [widget.username],
      cc: ['tishansaha@gmail.com'],
      bcc: ['mimumist@gmail.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
