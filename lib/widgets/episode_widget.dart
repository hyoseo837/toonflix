import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/webtoon_episode_model.dart';

class WebtoonEpisode extends StatelessWidget {
  final String webtoonId, episodeId;

  const WebtoonEpisode(
      {Key? key,
      required this.episode,
      required this.webtoonId,
      required this.episodeId})
      : super(key: key);

  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            episode.title,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          IconButton(
              onPressed: onButtonTap,
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
              ))
        ]),
      ),
    );
  }
}
