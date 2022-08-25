import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riseup_mailcheck_task/controller/domain_controller.dart';
import 'package:riseup_mailcheck_task/models/create_account.dart';
import 'package:riseup_mailcheck_task/models/create_account_error.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';
import 'dart:convert';

import 'package:riseup_mailcheck_task/view/send_email_page.dart';

class CreateAccountPage extends StatefulWidget {
  final String domain;

  CreateAccountPage({required this.domain});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  Api api = Api();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Page"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Flexible(
                      flex: 4,
                      //child: Text("@${widget.domain}")
                      child: Text(Get.find<DomainController>().domain.value.hydraMember!.first.domain)
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 85),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                        var accountResponse = await api.createAccount(
                            _userNameController.text + "@${widget.domain}", _passwordController.text);

                        if (jsonEncode(accountResponse).toString().contains("quota")) {
                          CreateAccount success = accountResponse;
                          Utils.successToast("${success.address}  created successfully");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SendEmailPage(username: success.address, password: _passwordController.text,);
                            },
                          ));
                        } else {
                          CreateAccountError error = accountResponse;
                          Utils.errorToast(error.violations.first.message);
                        }
                      } else {
                        Utils.errorToast("All fields required");
                      }
                    },

                    child: const Text("Create Account"),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

}
