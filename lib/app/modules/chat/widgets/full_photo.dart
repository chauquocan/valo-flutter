part of 'widgets.dart';

class FullPhoto extends StatelessWidget {
  final String url;

  const FullPhoto({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: url),
          imageProvider: CachedNetworkImageProvider(url),
          enableRotation: true,
          
        ),
      ),
    );
  }
}
