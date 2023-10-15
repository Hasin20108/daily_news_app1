import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_news_app1/models/category_model.dart';
import 'package:daily_news_app1/models/slider_model.dart';
import 'package:daily_news_app1/services/data.dart';
import 'package:daily_news_app1/services/slider_data.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];

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
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
            )
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
            child: Image.asset(image, height: 250,
                  fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
          ),
          Container(
            margin: EdgeInsets.only(top: 130.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
            
          )
        ],
      ),
      
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
