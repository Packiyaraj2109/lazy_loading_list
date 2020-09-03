

import 'package:lazy_loading_list/src/data/network/http_client.dart';
import 'package:lazy_loading_list/src/models/home/home_response_model.dart';

class   HomeRepository {
  Future<HomeResponseModel> fetchusers(String count) async {
    Map resp =
        await HttpClient().getMethod(count);
    return HomeResponseModel.fromJson(resp);
  }
}
