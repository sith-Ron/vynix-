import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart' as quill;

String deltaJsonFromController(quill.QuillController controller) {
  return jsonEncode(controller.document.toDelta().toJson());
}

quill.Document documentFromDeltaJson(String? value) {
  if (value == null || value.trim().isEmpty) {
    return quill.Document();
  }

  try {
    final decoded = jsonDecode(value);
    if (decoded is List) {
      return quill.Document.fromJson(decoded);
    }
  } catch (_) {
    // Fallback below.
  }

  return quill.Document()..insert(0, value);
}

List<String> tagsFromJson(String value) {
  try {
    final decoded = jsonDecode(value);
    if (decoded is List) {
      return decoded
          .map((item) => item.toString().trim().toLowerCase())
          .where((tag) => tag.isNotEmpty)
          .toSet()
          .toList(growable: false);
    }
  } catch (_) {
    // Fallback below.
  }
  return const [];
}

String plainTextFromDeltaJson(String value) {
  final document = documentFromDeltaJson(value);
  final text = document.toPlainText().replaceAll('\n', ' ').trim();
  if (text.isEmpty) {
    return 'Empty note';
  }
  return text;
}
