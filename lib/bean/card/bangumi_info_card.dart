import 'package:flutter/material.dart';
import 'package:kazumi/utils/constans.dart';
import 'package:kazumi/utils/utils.dart';
import 'package:kazumi/modules/bangumi/calendar_module.dart';
import 'package:kazumi/bean/card/network_img_layer.dart';
import 'package:kazumi/pages/menu/menu.dart';
import 'package:provider/provider.dart';

// 视频卡片 - 水平布局
class BangumiInfoCardV extends StatelessWidget {
  const BangumiInfoCardV({
    super.key,
    required this.bangumiItem,
  });

  final BangumiItem bangumiItem;

  @override
  Widget build(BuildContext context) {
    TextStyle style =
        TextStyle(fontSize: Theme.of(context).textTheme.labelMedium!.fontSize);
    String heroTag = Utils.makeHeroTag(bangumiItem.id);
    // final PlayerController playerController = Modular.get<PlayerController>();
    final navigationBarState = Provider.of<NavigationBarState>(context);
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            StyleString.safeSpace, 7, StyleString.safeSpace, 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: StyleString.imgRadius,
                topRight: StyleString.imgRadius,
                bottomLeft: StyleString.imgRadius,
                bottomRight: StyleString.imgRadius,
              ),
              child: AspectRatio(
                aspectRatio: 0.65,
                child: LayoutBuilder(builder: (context, boxConstraints) {
                  final double maxWidth = boxConstraints.maxWidth;
                  final double maxHeight = boxConstraints.maxHeight;
                  return Stack(
                    children: [
                      Hero(
                        tag: heroTag,
                        child: NetworkImgLayer(
                          src: bangumiItem.images?['large'] ?? '',
                          width: maxWidth,
                          height: maxHeight,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      children: [
                        TextSpan(
                          text: bangumiItem.nameCn == '' ? bangumiItem.name : (bangumiItem.nameCn ?? 'Placeholder'),
                          style: TextStyle(
                            fontSize: MediaQuery.textScalerOf(context).scale(
                                Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontSize!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('评分:${bangumiItem.rating?.score.toString() ?? '0.0'}',
                      style: style),
                  Row(
                    children: [
                      Text(bangumiItem.type == 2 ? '日本' : '国创', style: style),
                      const SizedBox(width: 3),
                      const Text('·'),
                      const SizedBox(width: 3),
                      Text(bangumiItem.airDate ?? '', style: style),
                    ],
                  ),
                  Row(
                    children: [
                      Text(bangumiItem.summary ?? '', style: style),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () async {
                        
                      },
                      child: const Text('追番'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}