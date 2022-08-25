import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riseup_mailcheck_task/controller/domain_controller.dart';
import 'package:riseup_mailcheck_task/models/domain.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';
import 'package:riseup_mailcheck_task/utils/utils.dart';
import 'package:riseup_mailcheck_task/view/create_account_page.dart';

class QueryPage extends StatelessWidget {

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
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 5, end: 50),
            duration: const Duration(seconds: 5),
            builder: (BuildContext context, double size, Widget? child) {
              return IconButton(
                iconSize: size,
                color: Colors.blue,
                icon: child!,
                onPressed: () {
                },
              );
            },
            child: const Icon(Icons.query_builder),
          ),
          ElevatedButton(
            onPressed: () async {
              Domain response = await api.getDomain();
              domainName = response.hydraMember!.first.domain;

              if(domainName.isNotEmpty) {
                Utils.successToast("'$domainName' domain retrieved Successfully");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    //return CreateAccountPage(domain: domainName,);
                    return CreateAccountPage(domain: domainController.domain.value.hydraMember!.first.domain,);
                  },
                ));
              } else {
                Utils.errorToast("Something went wrong, please try again");
              }


            },
            child: const Text("Please Query Domain"),
          ),
        ],
      ),
    );
  }
}
