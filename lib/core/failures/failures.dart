import 'dart:core';

class Failure implements Exception {
  final String message;

  Failure({
    required this.message,
  });
}
