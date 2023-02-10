import 'dart:convert';
import 'dart:io';

import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_response.dart';

RecognitionResponse defaultRecognitionResponse = RecognitionResponse.fromJson(
  jsonDecode(File('test_resources/mocks/recognition_response.json').readAsStringSync()),
);
