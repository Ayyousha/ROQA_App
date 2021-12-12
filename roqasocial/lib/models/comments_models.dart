class CommentModels
{
  String? name;
  String? image;
  String? text;


  CommentModels({
    this.name,
    this.image,
    this.text,


  });

  CommentModels.fromJson(Map<String,dynamic> Json)
  {
    name = Json['name'];
    image = Json['image'];
    text = Json['text'];


  }

  Map<String,dynamic> toJson()
  {
    return{
      'name' : name,
      'image' : image,
      'text' : text,
    };
  }
}