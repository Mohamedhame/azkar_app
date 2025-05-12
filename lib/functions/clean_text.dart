  String cleanHadithBody(String htmlText) {
    String cleaned = htmlText.replaceAll(RegExp(r'<[^>]+>'), '');

    cleaned = cleaned.replaceAll(RegExp(r'\[/?[^\]]+\]'), '');

    cleaned = cleaned.replaceAll('\n', ' ').trim();

    return cleaned;
  }