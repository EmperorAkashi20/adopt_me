import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoView extends ConsumerWidget {
  final String imageUrl;
  const PhotoView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [CloseButton(color: Colors.black)],
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false, // Set it to false
          minScale: 0.5,
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
