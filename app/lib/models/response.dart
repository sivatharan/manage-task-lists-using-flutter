
class Response{
  bool status;
  String message;
  dynamic result;


  Response({
    this.status,
    this.message,
    this.result

  });

  factory Response.fromJson(Map<String, dynamic> json){
    return Response(
      status: json["status"],
      message:json["message"],
      result:json["result"]
    );
  }
}