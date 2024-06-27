import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mime/mime.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return Constants.zeroDec;
    } else {
      return this!;
    }
  }
}

extension NonNullBoolean on bool? {
  bool orBool() {
    if (this == null) {
      return Constants.isEmpty;
    } else {
      return this!;
    }
  }
}

extension DateTimeExtension on DateTime {
  Timestamp toTimestamp() {
    int seconds = this.millisecondsSinceEpoch ~/ 1000;
    int nanoseconds = (this.millisecondsSinceEpoch % 1000) * 1000000;
    return Timestamp(seconds, nanoseconds);
  }
}

extension NonNullMap on Map<String, bool>? {
  Map<String, bool> orEmpty() {
    if (this == null) {
      return {};
    } else {
      return this!;
    }
  }
}

extension DateFormatters on String {
  String toFormattedDateYear() {
    try {
      if (isEmpty) {
        return Constants.empty;
      } else {
        final parsedDate = DateTime.parse(this);
        final formattedDate = DateFormat('E, MMM d, yyyy').format(parsedDate);
        return formattedDate;
      }
    } catch (e) {
      // Handle the exception here, e.g., log an error or return a default value
      print('Error parsing date: $e');
      return this;
    }
  }
  
  DateTime? toDateTime() {
    // Regular expression to match the Firestore Timestamp format
    final regex = RegExp(r'Timestamp\(seconds=(\d+), nanoseconds=(\d+)\)');
    final match = regex.firstMatch(this);

    if (match != null) {
      int seconds = int.parse(match.group(1)!);
      int nanoseconds = int.parse(match.group(2)!);
      return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + nanoseconds ~/ 1000000,
      );
    } else {
      return null;
    }
  }
}

extension FileExtension on File {
  String convertToBase64() {
    final bytes = readAsBytesSync();
    String base64Str = base64Encode(bytes);
    String? mimeType = lookupMimeType(this.path);
    return 'data:$mimeType;base64,$base64Str';
  }
}
