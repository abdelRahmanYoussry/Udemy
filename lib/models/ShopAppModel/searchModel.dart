class SearchModel {
   bool ?status;
    Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =(json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
   int? currentPage;
  List<Product> data=[];
  String ? firstPageUrl;
    int ?from;
   int ?lastPage;
  String ?lastPageUrl;
 String ?path;
 int ?perPage;
 int ?to;
   int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add( Product.fromJson(v));
    });
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


class Product {
  int ?id;
  dynamic price;
  dynamic oldPrice;
 int? discount;
   String? image;
  String ?name;
  String ?description;


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




