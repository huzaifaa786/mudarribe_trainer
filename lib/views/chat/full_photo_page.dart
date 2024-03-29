import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatefulWidget {
  final String? url;

  const FullPhotoPage({super.key, required this.url});

  @override
  State<FullPhotoPage> createState() => _FullPhotoPageState();
}

class _FullPhotoPageState extends State<FullPhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Full photo'.tr,
        ) ,
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.url!),
      ),
    );
  }
}
