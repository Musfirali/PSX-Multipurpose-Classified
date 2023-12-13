import 'package:flutter/material.dart';

class BlogListEmptyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SizedBox());
  }
}
