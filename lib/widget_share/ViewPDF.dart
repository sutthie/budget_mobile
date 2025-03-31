import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPDF extends StatelessWidget {
  final String url;

  const ViewPDF(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${url}',
          style: TextStyle(color: Colors.white),
        ),
        //backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: PDF().cachedFromUrl(
          //"http://10.130.230.64/budget1/Follow/doc/64-12-01 ขอให้จัดหาวัสดุฯ.pdf",
          url,
          maxAgeCacheObject: Duration(days: 30), // Set the duration of cache
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
