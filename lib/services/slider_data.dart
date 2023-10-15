import 'package:daily_news_app1/models/slider_model.dart';

List<SliderModel> getSliders(){
  List<SliderModel> sliders = [];
  SliderModel sliderModel = new SliderModel();

  sliderModel.name = "Business";
  sliderModel.image = "images/business.jpg";
  sliders.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.name = "Entertainment";
  sliderModel.image = "images/entertainment.jpg";
  sliders.add(sliderModel);

  sliderModel = new SliderModel();
  sliderModel.name = "Sports";
  sliderModel.image = "images/sports.jpg";
  sliders.add(sliderModel);


  return sliders;
}
