import 'package:flutter/material.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CarouselView(
        itemExtent: MediaQuery.of(context).size.width - 60,
        scrollDirection: Axis.horizontal,
        children:
            [
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
              'https://ww2.sinaimg.cn/mw690/005EUiO2ly1hxj8yk8u5oj30m81c37d9.jpg',
            ].map((item) {
              return Image.network(item, fit: BoxFit.cover);
            }).toList(),
      ),
    );
  }
}
