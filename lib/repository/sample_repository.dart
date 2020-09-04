import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:listviewgroupingsample/model/sample_model.dart';

class SampleService {
  Future<List<SampleModel>> getSampleList(int take, int skip) async {
    //var params = {'take': take.toString(), 'skip': skip.toString()};
    var result = json.decode(await rootBundle.loadString('assets/mock/list.json'));
    if (result == null) return null;
    var output = List<SampleModel>();
    for (Map<String, dynamic> json in result) {
      output.add(SampleModel.fromJson(json));
    }
    return output;
  }
}
