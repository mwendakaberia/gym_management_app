class UserModel{
  String? uid;
  String? email;
  String? userName;
  String? fullName;
  String? picURL;

  UserModel({this.uid, this.email , this.userName , this.fullName, this.picURL});

  //receiving data from server

  factory UserModel.formMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      fullName: map['fullName'],
      picURL: map['picURL']

    );
  }

  // sending data to server

  Map<String,dynamic> toMap(){
    return {
      'uid' : uid ,
      'email' : email,
      'userName' : userName ,
      'fullName' : fullName ,
      'picURL' : picURL ,
    };
  }
}