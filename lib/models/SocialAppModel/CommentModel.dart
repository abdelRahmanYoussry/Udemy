class CommentModel{
  late String ?name;
  late String? uid;
  late String ?image;
  late String ?dateTime;
  late String ?text;

  CommentModel({
    this.name,
    this.dateTime,
    this.text,
    this.uid,
    this.image,
  });

  CommentModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uid=json['uid'];
    image=json['image'];
  }

  Map<String,dynamic>toMap() {
    return{
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uid':uid,
      'image':image,
    };

  }
}