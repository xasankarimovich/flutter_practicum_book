import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownWithFooter extends StatelessWidget {
  final String markdownData;
  final Widget footer;

  const MarkdownWithFooter({
    super.key,
    required this.markdownData,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Markdown(
            data: markdownData,
          ),
        ),
        const SliverToBoxAdapter(
          child: Text("Salom"),
        ),
      ],
    );
  }
}
