class UserModel{
  String? uid;
  String? email;
  String? userName;
  String? fullName;

  UserModel({this.uid, this.email , this.userName , this.fullName});

  //receiving data from server

  factory UserModel.formMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      fullName: map['fullName'],

    );
  }

  // sending data to server

  Map<String,dynamic> toMap(){
    return {
      'uid' : uid ,
      'email' : email,
      'userName' : userName ,
      'fullName' : fullName ,
    };
  }
}