import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riseup_mailcheck_task/controller/domain_controller.dart';
import 'package:riseup_mailcheck_task/models/domain.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';
import 'package:riseup_mailcheck_task/view/create_account_page.dart';

class QueryPage extends StatefulWidget {
  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {

  Api api = Api();
  String domainName = "";
  final DomainController domainController = Get.put(DomainController());

  @override
  Widget build(BuildContext context) {
    return Center(
      //child: Text("Joy Volanath"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              Domain response = await api.getDomain();
              domainName = response.hydraMember!.first.domain;

              if(domainName.isNotEmpty) {
                Utils.successToast("Successfully this '$domainName' domain retrieved");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return CreateAccountPage(domain: domainName,);
                    //return CreateAccountPage(domain: domainController.domain.value.hydraMember!.first.domain,);
                  },
                ));
              } else {
                Utils.errorToast("Something went wrong, please try again");
              }


            },
            child: const Text("Please Query Domain"),
          ),
          SizedBox(height: 30,),
          //Text("Joy Volanath"),
          //Text(Utils.domainName),
          //Text(domainName),
          //Text(domainController.domain.value.hydraMember!.first.domain),
        ],
      ),
    );
  }
}
