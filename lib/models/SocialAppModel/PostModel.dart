class PostModel{
  late String ?name;
  late String? uid;
  late String ?image;
  late String ?dateTime;
  late String ?text;
  late String ?postImage;
  //make a comment
  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.uid,
    this.image,
    this.postImage,
    //make a comment
  });

  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uid=json['uid'];
    image=json['image'];
    postImage=json['postImage'];
    //make a comment

  }

  Map<String,dynamic>toMap() {
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uid':uid,
      'image':image,
      'postImage':postImage,
    };

  }
}