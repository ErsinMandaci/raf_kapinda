import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:groceries_app/core/constants/string.dart';
import 'package:groceries_app/model/groceries.dart';

class ProductService {
  Future<Groceries> loadJson() async {
    final jsonString = await rootBundle.loadString(StringConst.jsonProduct);
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
    final groceries = Groceries.fromJson(jsonData);
    return groceries;
  }
}
