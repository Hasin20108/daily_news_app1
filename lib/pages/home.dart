import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_news_app1/models/article_model.dart';
import 'package:daily_news_app1/models/category_model.dart';
import 'package:daily_news_app1/models/slider_model.dart';
import 'package:daily_news_app1/services/data.dart';
import 'package:daily_news_app1/services/news.dart';
import 'package:daily_news_app1/services/slider_data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    sliders = getSliders();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Daily"),
            Text(" News",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      height: 70, //eita chara kaj kore na
                      child: ListView.builder(
                          shrinkWrap: true, // ei line er kaj bujhte pari nai
                          scrollDirection: Axis.horizontal,
                          itemCount: categories
                              .length, // eita na dile index out of range dekhay index should be less then 5.5
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                image: categories[index].image,
                                categoryName: categories[index].categoryName);
                          }),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Breaking News!",
                            style: TextStyle(
                                color: Colors.redAccent[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                fontFamily: 'Young_Serif'),
                          ),
                          Text(
                            "views all",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    CarouselSlider.builder(
                      itemCount: sliders.length,
                      itemBuilder: (context, index, realIndex) {
                        String? res = sliders[index].image;
                        String? res1 = sliders[index].name;

                        return buildImage(res!, index, res1!);
                      },
                      options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: ((index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          })),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(child: buildIndicator()),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Text(
                            "views all",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                                imageUrl: articles[index].urlToImage!,
                                desc: articles[index].description!,
                                title: articles[index].title!);
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image,
                  height: 250,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.only(left: 10.0),
              margin: EdgeInsets.only(top: 170.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: JumpingDotEffect(
            activeDotColor: Colors.blue, dotWidth: 10, dotHeight: 10),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16), // ei line er kaj bujhte pari nai
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
                child: Text(categoryName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
          )
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc;
  BlogTile({required this.imageUrl, required this.desc, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
