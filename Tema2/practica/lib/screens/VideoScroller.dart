import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScroller extends StatelessWidget {
  final List<String> videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Scroller"),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Cambia a Axis.horizontal para scroll horizontal
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {}); // Actualiza el estado cuando el video esté listo
      })
      ..setLooping(true) // Configura el loop del video
      ..play(); // Inicia la reproducción automáticamente
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera los recursos cuando el widget se elimine
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox.expand(
            // Hace que el video ocupe todo el espacio disponible
            child: FittedBox(
              fit: BoxFit.cover, // Escala el video para cubrir toda la pantalla
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(), // Muestra un indicador mientras se carga el video
          );
  }
}
