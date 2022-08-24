import 'dart:convert';
import 'package:riseup_mailcheck_task/models/create_account.dart';
import 'package:riseup_mailcheck_task/models/create_account_error.dart';
import 'package:riseup_mailcheck_task/models/domain.dart';
import 'package:riseup_mailcheck_task/utils/remote_config.dart';
import 'package:http/http.dart' as http;


class Api{

  String baseUrl = RemoteConfig.config["BASE_URL"]??"";

  Future<Domain> getDomain() async {

    String domain = RemoteConfig.config["DOMAIN"]??"";
    print("DOMAIN URL : "+baseUrl+domain);

    var response = await http.get(
      Uri.parse(baseUrl + domain),
    );

    if (response.statusCode == 200) {
      print("=======domain response======= : "+response.body);
      return domainFromJson(response.body);
    } else {
      print("domain error : "+response.body);
      throw Exception('Failed to load domain data');
    }

  }

  Future createAccount(String username, String password) async {

    print("username : $username");
    print("password : $password");
    String account = RemoteConfig.config["CREATE_ACCOUNT"]??"";

    final body = {
      "address": username,
      "password": password
    };

    var response = await http.post(
      Uri.parse(baseUrl + account),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print("=======account response======= : "+response.body);
      return createAccountFromJson(response.body);
    } else {
      print("=======account error response======= : "+response.body);
      return createAccountErrorFromJson(response.body);
    }

  }




}
