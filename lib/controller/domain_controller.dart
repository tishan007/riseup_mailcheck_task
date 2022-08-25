
import 'package:get/state_manager.dart';
import 'package:riseup_mailcheck_task/models/domain.dart';
import 'package:riseup_mailcheck_task/utils/api.dart';

class DomainController extends GetxController {

  Api api = Api();
  var domain = Domain(hydraMember: []).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getDomainData();
    super.onInit();
  }


  void getDomainData() async {
    var domainValue = await api.getDomain();
    if(domainValue!=null) {
      domain.value = domainValue;
    }
  }

}