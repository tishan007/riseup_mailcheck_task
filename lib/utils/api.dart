import 'dart:convert';
import 'package:riseup_mailcheck_task/models/create_account.dart';
import 'package:riseup_mailcheck_task/models/create_account_error.dart';
import 'package:riseup_mailcheck_task/models/domain.dart';
import 'package:riseup_mailcheck_task/models/message.dart';
import 'package:riseup_mailcheck_task/models/token.dart';
import 'package:riseup_mailcheck_task/utils/remote_config.dart';
import 'package:http/http.dart' as http;
import 'package:riseup_mailcheck_task/utils/utils.dart';


class Api{

  String baseUrl = RemoteConfig.config["BASE_URL"]??"";

  Future<Domain> getDomain() async {

    String domain = RemoteConfig.config["DOMAIN"]??"";

    var response = await http.get(
      Uri.parse(baseUrl + domain),
    );

    if (response.statusCode == 200) {
      return domainFromJson(response.body);
    } else {
      throw Exception('Failed to load domain data');
    }

  }

  Future createAccount(String username, String password) async {

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
      return createAccountFromJson(response.body);
    } else {
      return createAccountErrorFromJson(response.body);
    }

  }

  Future generateToken(String username, String password) async {

    String account = RemoteConfig.config["TOKEN"]??"";

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

    if (response.statusCode == 200) {
      return tokenFromJson(response.body);
    } else {
      throw Exception('Failed to load token data');
    }

  }

  Future<Message> getMessage() async {

    String domain = RemoteConfig.config["MESSAGE"]??"";

    var response = await http.get(
      Uri.parse(baseUrl + domain),
      headers: {
        "Authorization": "Bearer ${Utils.token}",
      },
    );

    if (response.statusCode == 200) {
      return messageFromJson(response.body);
    } else {
      throw Exception('Failed to load MESSAGE data');
    }

  }




}
