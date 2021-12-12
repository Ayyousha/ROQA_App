class UsersModels
{
  String? uId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? cover;
  String? bio;

  UsersModels({
    this.uId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
    this.cover,
    this.bio,
});

  UsersModels.fromJson(Map<String,dynamic> Json)
  {
    uId = Json['uId'];
    name = Json['name'];
    email = Json['email'];
    password = Json['password'];
    phone = Json['phone'];
    image = Json['image'];
    cover = Json['cover'];
    bio = Json['bio'];

  }

  Map<String,dynamic> toJson()
  {
    return{
  'uId' : uId,
  'name' : name,
  'email' : email,
  'password' : password,
  'phone' : phone,
  'image' : image,
  'cover' : cover,
  'bio' : bio,
  };
 }
}