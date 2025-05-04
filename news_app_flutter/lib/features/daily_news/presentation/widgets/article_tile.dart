// lib/features/daily_news/presentation/widgets/article_tile.dart
// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity article;

  const ArticleWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, top: 8, bottom: 8),
      // Ajustei a altura para não travar null em MediaQuery
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 2.2,
      ),
      child: Row(
        children: [
          _buildImage(context),
          const SizedBox(width: 12),
          Expanded(child: _buildTitleAndDescription()),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl = article.urlToImage;
    if (imageUrl == null || imageUrl.isEmpty) {
      // placeholder quando não há imagem
      return Container(
        width: MediaQuery.of(context).size.width / 3,
        height: double.infinity,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported, size: 40),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (ctx, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image(
          image: imageProvider,
          width: MediaQuery.of(context).size.width / 3,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      placeholder: (ctx, url) => SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: double.infinity,
        child: const Center(child: CupertinoActivityIndicator()),
      ),
      errorWidget: (ctx, url, err) => SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        height: double.infinity,
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    final title = article.title?.trim();
    final description = article.description?.trim();
    final publishedAt = article.publishedAt?.split('T').first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title?.isNotEmpty == true ? title! : 'Sem título',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description?.isNotEmpty == true ? description! : 'Sem descrição.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        if (publishedAt != null && publishedAt.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.timeline_outlined, size: 16),
              const SizedBox(width: 4),
              Text(
                publishedAt,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }
}
