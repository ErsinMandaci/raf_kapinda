import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:groceries_app/core/constants/string.dart';
import 'package:groceries_app/model/groceries.dart';

class ProductService {
  Future<Groceries?> loadJson() async {
    try {
      final jsonString = await rootBundle.loadString(StringConst.jsonProduct);
      final jsonData = jsonDecode(jsonString);

      if (jsonData is! Map<String, dynamic>) {
        throw FormatException('Unexpected JSON structure');
      }

      final groceries = Groceries.fromJson(jsonData);
      return groceries;
    } on FormatException catch (e) {
      throw Exception('Format Exception: $e');
    } on PlatformException catch (e) {
      throw Exception('Platform Exception: $e');
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }
}
