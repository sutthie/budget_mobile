import 'package:url_launcher/url_launcher.dart';

class OpenUrlBrowser {
  String urlPath = 'http://10.130.230.64/budget1/Follow/doc/';

  launchURL(urlStr, fileName) async {
    if (urlStr == "") urlStr = urlPath;

    String fullUrl = urlStr + Uri.encodeComponent(fileName);

    Uri uri = Uri.parse(fullUrl);
    if (await launchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      throw 'Could not launch $fullUrl';
    }
  }
}
