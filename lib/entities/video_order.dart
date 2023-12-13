class VideoOrder {
  int? order;

  String? videoId;

  VideoOrder({
    required this.order,
    required this.videoId
  });

  factory VideoOrder.fromJson(Map<String, dynamic> videoOrder) {

    return VideoOrder(order: videoOrder["order"], videoId: videoOrder["videoId"]);

  }
}