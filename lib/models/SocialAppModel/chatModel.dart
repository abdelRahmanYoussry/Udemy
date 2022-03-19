class MessagesChatModel{
 late String ?receiverId;
 late String? senderID;
 late String ?text;
 late String? dateTime;
 late String? image;


  MessagesChatModel({
    this.receiverId,
    this.senderID,
     this.text,
    this.dateTime,
    this.image

  });

MessagesChatModel.fromJson(Map<String,dynamic>json){
  receiverId=json['receiverId'];
  senderID=json['senderID'];
  text=json['text'];
  dateTime=json['dateTime'];
  image=json['image'];

}

Map<String,dynamic>toMap() {
return{
  'receiverId':receiverId,
  'senderID':senderID,
  'text':text,
  'dateTime':dateTime,
  'image':image
};

}
}