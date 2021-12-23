part of 'widgets.dart';

class FullPhoto extends StatelessWidget {
  final String url;
  final String? sender;

  const FullPhoto({Key? key, required this.url, this.sender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: sender == null ? const Text('') : Text('Người gửi: $sender'),
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
