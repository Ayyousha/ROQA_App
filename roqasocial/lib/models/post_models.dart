class PostModels
{
  String? uId;
  String? name;
  late String? bio;
  late String? cover;
  String? imagePost;
  String? image;
  String? dateTime;
  String? text;
  String? hashTag;

  PostModels({
    this.uId,
    this.name,
    this.bio,
    this.cover,
    this.imagePost,
    this.image,
    this.dateTime,
    this.text,
    this.hashTag,

  });

  PostModels.fromJson(Map<String,dynamic> Json)
  {
    uId = Json['uId'];
    name = Json['name'];
    bio = Json['bio'];
    cover = Json['cover'];
    imagePost = Json['imagePost'];
    image = Json['image'];
    dateTime = Json['dateTime'];
    text = Json['text'];
    hashTag = Json['hashTag'];


  }

  Map<String,dynamic> toJson()
  {
    return{
      'uId' : uId,
      'name' : name,
      'bio' : bio,
      'cover' : cover,
      'imagePost' : imagePost,
      'image' : image,
      'dateTime' : dateTime,
      'text' : text,
      'hashTag' : hashTag,
    };
  }
}