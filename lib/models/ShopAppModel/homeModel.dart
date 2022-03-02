class HomeModel
{
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map <String,dynamic> json)
  {
 status=json['status'];
 data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

   HomeDataModel.fromJson(Map<String,dynamic> json)
   {
      json['banners'].forEach((element){
        banners.add(BannerModel.fromJson(element));
      });
      json['products'].forEach((element){
        products.add(ProductModel.fromJson(element));
      });
   }
}

class BannerModel
{
  late int id;
   String? image;
BannerModel.fromJson(Map<String,dynamic> json)
{
id=json['id'];
image=json['image'];

}
}

class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ?image;
  String ?name;
  late bool favorites;
  late bool inCart;
  ProductModel.fromJson(Map<String,dynamic> json)
  {
   id=json['id'];
   price=json['price'];
   oldPrice=json['old_price'];
   discount=json['discount'];
   name=json['name'];
   image=json['image'];
   favorites=json['in_favorites'];
   inCart=json['in_cart'];
  }

}