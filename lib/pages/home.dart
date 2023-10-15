import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_news_app1/models/category_model.dart';
import 'package:daily_news_app1/models/slider_model.dart';
import 'package:daily_news_app1/services/data.dart';
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
  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    sliders = getSliders();
    super.initState();
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
      body: Container(
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
                  Text("Breaking News!", style: TextStyle(color: Colors.redAccent[700], fontWeight: FontWeight.bold, fontSize: 18.0, fontFamily: 'Young_Serif'),),
                  Text("views all", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 15.0),),
                
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
                  Text("Trending News!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
                  Text("views all", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 15.0),),
                
                ],
              ),
            ),  
            SizedBox(
              height: 20.0,
            ),
          ],
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
    effect: JumpingDotEffect(activeDotColor: Colors.blue,dotWidth: 10, dotHeight: 10),  
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
