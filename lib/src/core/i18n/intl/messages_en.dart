// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "musicDetails_appleMusicButtonlabel":
            MessageLookupByLibrary.simpleMessage("Open in Apple Music"),
        "musicDetails_spotifyButtonlabel":
            MessageLookupByLibrary.simpleMessage("Open in spotify"),
        "musicRecognition_failed_noMatch":
            MessageLookupByLibrary.simpleMessage("No match found"),
        "musicRecognition_failed_other": MessageLookupByLibrary.simpleMessage(
            "An unexpected error occured. Please try again"),
        "musicRecognition_failed_title":
            MessageLookupByLibrary.simpleMessage("Recognition failed"),
        "musicRecognition_failed_tryAgainButtonLabel":
            MessageLookupByLibrary.simpleMessage("Try again"),
        "musicRecognition_initialActionIndicatorLabel":
            MessageLookupByLibrary.simpleMessage("Tap to start recognition"),
        "musicRecognition_loadingLabel":
            MessageLookupByLibrary.simpleMessage("Looking for matches..."),
        "musicRecognition_recordFailed": MessageLookupByLibrary.simpleMessage(
            "We are unable to record a sample, did you provide microphone access ?")
      };
}
