import 'package:drugpedia/src/controller/video_controller.dart';
import 'package:flutter_svg/svg.dart';

import '../../fetch/get_json.dart';
import 'components/carousel.dart';

import 'package:flutter/material.dart';
import '../../models/detail_model.dart';
import '../../theme/home_text_theme.dart';

class DetailScreen extends StatelessWidget {
  final String drugName;
  final Color color;
  final String svg;

  DetailScreen({
    super.key,
    required this.drugName,
    required this.color,
    required this.svg,
  });

  late final Future<DetailModel> jsonData = GetJson.getData(drugName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jsonData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: color,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      snapshot.data!.name,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: homeTheme.textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset(
                                color: Colors.black.withOpacity(0.75),
                                svg,
                                width: 32,
                                height: 32,
                                fit: BoxFit.scaleDown,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data!.intro,
                                  style: homeTheme.textTheme.bodySmall,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ImageCarousel(
                            drugType: drugName,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '특징',
                                style: homeTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data!.characteristics,
                                  style: homeTheme.textTheme.bodySmall,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '효과',
                                style: homeTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data!.effects,
                                  style: homeTheme.textTheme.bodySmall,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '부작용',
                                style: homeTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  snapshot.data!.sideEffects,
                                  style: homeTheme.textTheme.bodySmall,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '관련영상',
                                style: homeTheme.textTheme.bodyMedium,
                              ),
                              Column(
                                children: [
                                  VideoController(
                                    videoId: snapshot.data!.uri.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
