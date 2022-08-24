import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riseup_mailcheck_task/models/create_account.dart';
import 'package:riseup_mailcheck_task/models/create_account_error.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';
import 'dart:convert';

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
    Size screenSize = MediaQuery.of(context).size;
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
                          //hintStyle: Utils.hintTextStyle,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                      flex: 4,
                      child: Text("@${widget.domain}")
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  //style: Utils.inputFormTextStyle,
                  obscureText: !_passwordVisible,   //This will obscure text dynamically
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    //hintStyle: Utils.hintTextStyle,
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
                    //gradient: Utils.blueBtnGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                        var accountResponse = await api.createAccount(
                            _userNameController.text + "@${widget.domain}",
                            _passwordController.text);

                        if (jsonEncode(accountResponse).toString().contains("address")) {
                          CreateAccount success = accountResponse;
                          Utils.successToast("${success.address}  created successfully");
                        } else {
                          CreateAccountError error = accountResponse;
                          Utils.errorToast(error.violations.first.message);
                        }
                      } else {
                        Utils.errorToast("All fields required");
                      }
                    },

                    child: Text("Create Account"),
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
