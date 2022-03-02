class SocialUserModel{
 late String ?name;
 late String? email;
 late String ?phone;
 late String? uid;
 late String ?image;
 late String ?coverImage;
 late String ?bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
     this.phone,
    this.uid,
     this.image,
     this.bio,
    this.coverImage,
     this.isEmailVerified,
  });

SocialUserModel.fromJson(Map<String,dynamic>json){
  name=json['name'];
  email=json['email'];
  phone=json['phone'];
  uid=json['uid'];
  image=json['image'];
  coverImage=json['coverImage'];
  bio=json['bio'];
  isEmailVerified=json['isEmailVerified'];
}

Map<String,dynamic>toMap() {
return{
  'name':name,
  'email':email,
  'phone':phone,
  'uid':uid,
  'image':image,
  'coverImage':coverImage,
  'bio':bio,
  'isEmailVerified':isEmailVerified,
};

}
}