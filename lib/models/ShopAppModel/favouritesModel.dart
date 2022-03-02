class FavouritesModel {
 late bool status;
 late Data? data;

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =(json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int? currentPage;
   List<FavouriteData> data=[];
  late String firstPageUrl;
  late int ?from;
  late int ?lastPage;
  late  String ?lastPageUrl;
  late String ?path;
  late  int ?perPage;
  late  int ?to;
  late  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    //if (json['data'] != null) {
     //data = new List<FavouriteData>();
      json['data'].forEach((v) {
        data.add( FavouriteData.fromJson(v));
      });
  //  }
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class FavouriteData {
 late int ?id;
 late Product ?product;


  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ?  Product.fromJson(json['product']) : null)!;
  }

}

class Product {
 late int ?id;
 dynamic price;
 dynamic oldPrice;
 late int? discount;
 late  String? image;
 late String ?name;
 late String ?description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}




