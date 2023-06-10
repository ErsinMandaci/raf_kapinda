import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:groceries_app/core/constants/string.dart';

class ProductService {
  Future<Map<String, dynamic>> fetchProduct() async {
    final String response =
        await rootBundle.loadString(StringConst.jsonProduct);
    final Map<String, dynamic> data = jsonDecode(response);

    return data;
  }
}
