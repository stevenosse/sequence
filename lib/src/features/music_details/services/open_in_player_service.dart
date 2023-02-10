import 'dart:developer';

import 'package:url_launcher/url_launcher_string.dart';

class OpenInPlayerService {
  Future<void> open(String url) async {
    if (!await canLaunchUrlString(url)) {
      final result = await launchUrlString(url, mode: LaunchMode.externalNonBrowserApplication);

      if (!result) {
        log('Failed to open url: $url');
      }
    }
  }
}
