import 'package:hyggewalls/models/category_model.dart';

String apiKEY = "Enter the API KEY here";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = new List();
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.imgUrl =
  "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "4k Wallpapers";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl =
  "https://images.pexels.com/photos/1109354/pexels-photo-1109354.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Abstract";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl =
  "https://images.pexels.com/photos/889929/pexels-photo-889929.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Aquatic\nWildlife";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();



  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Wild Life";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1107717/pexels-photo-1107717.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Nature";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/373912/pexels-photo-373912.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "City";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl =
  "https://images.pexels.com/photos/970089/pexels-photo-970089.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Minimal\nWallpapers";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.imgUrl =
  "https://images.pexels.com/photos/2882234/pexels-photo-2882234.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Road\nJournies";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/3806690/pexels-photo-3806690.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoryModel.categoryName = "Motivation";

  categories.add(categoryModel);
  categoryModel = new CategoryModel();



  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Bikes";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/2301226/pexels-photo-2301226.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Cars";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categoryName = "Street Art";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
