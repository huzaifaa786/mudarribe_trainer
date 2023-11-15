class FileSelectorApiException implements Exception {
  final String title;
  final String? message;

  FileSelectorApiException({
    required this.title,
    this.message,
  });

  @override
  String toString() {
    return 'FileSelectorApiException: $title ${message != null ? '- $message' : ''}';
  }
}