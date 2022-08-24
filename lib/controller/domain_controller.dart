
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
    var domain_value = await api.getDomain();
    if(domain_value!=null) {
      domain.value = domain_value;
    }
  }

}