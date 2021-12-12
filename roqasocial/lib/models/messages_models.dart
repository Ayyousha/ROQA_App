class MessagesModels
{
  String? senderUId;
  String? receiverUId;
  String? message;
  String? dateTime;


  MessagesModels({
    this.senderUId,
    this.receiverUId,
    this.message,
    this.dateTime,

  });

  MessagesModels.fromJson(Map<String,dynamic> Json)
  {
    senderUId = Json['senderUId'];
    receiverUId = Json['receiverUId'];
    message = Json['message'];
    dateTime = Json['dateTime'];


  }

  Map<String,dynamic> toJson()
  {
    return{
      'senderUId' : senderUId,
      'receiverUId' : receiverUId,
      'message' : message,
      'dateTime' : dateTime,

    };
  }
}