// Web-specific download implementation
// This file is only used when dart:html is available (web builds)

import 'dart:html' as html;
import 'dart:convert';

void downloadFile(String content, String fileName) {
  try {
    // Create a blob with the content
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes], 'text/plain');

    // Create a URL for the blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a temporary anchor element and trigger download
    final anchor =
        html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..style.display = 'none';

    // Add to DOM, click, and remove
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);

    // Clean up the URL
    html.Url.revokeObjectUrl(url);

    print('Answer key download initiated: $fileName');
  } catch (e) {
    print('Error downloading file on web: $e');
    // Fallback: print to console
    print('=== ANSWER KEY FILE: $fileName ===');
    print(content);
    print('=== END ANSWER KEY ===');
  }
}
