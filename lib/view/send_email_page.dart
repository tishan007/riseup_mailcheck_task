import 'package:flutter/material.dart';
import 'package:riseup_mailcheck_task/models/message.dart';
import 'package:riseup_mailcheck_task/models/token.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';

class SendEmailPage extends StatefulWidget {
  final String username, password;

  SendEmailPage({required this.username, required this.password});

  @override
  _SendEmialPageState createState() => _SendEmialPageState();
}

class _SendEmialPageState extends State<SendEmailPage> {

  Api api = Api();
  bool isToken = false;

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
        title: const Text("Send mail"),
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
                  if(response.token.isNotEmpty) {
                    Utils.successToast("Token generated successfully");
                    Utils.token = response.token;
                    isToken = true;
                  } else {
                    Utils.errorToast("Token not generated");
                  }
                },
                child: const Text("Get Token"),
              ),
              SizedBox(height: 150,),
              (!isToken) ? Text("You need token to send email") : Text("You can send an email"),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async {
                  if(isToken) {
                    Message response = await api.getMessage();
                    Utils.successToast("${response.hydraTotalItems}");

                  } else {
                    Utils.errorToast("Token needed");
                  }
                },
                child: const Text("Send Email"),
              ),
            ],
          ),
        )
      ],
    );
  }

}
