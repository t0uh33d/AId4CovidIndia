class PostModel {
  String name,
      address,
      city,
      state,
      contact,
      location,
      userId,
      postId,
      timeDisplay;
  var bloodGroups;
  int timestamp;
  bool plasma, bed, oxygen, tablets, injection, ventilator;

  PostModel(
      {this.name,
      this.address,
      this.city,
      this.state,
      this.contact,
      this.location,
      this.bloodGroups,
      this.plasma,
      this.bed,
      this.oxygen,
      this.tablets,
      this.ventilator,
      this.injection,
      this.userId,
      this.postId,
      this.timestamp,
      this.timeDisplay});

  PostModel.fromSnapshot(dynamic value) {
    name = value['name'] ?? '';
    address = value['address'] ?? '';
    city = value['city'] ?? '';
    state = value['state'] ?? '';
    contact = value['contact'] ?? '';
    location = value['location'] ?? '';
    bloodGroups = value['bloodGroups'] ?? '';
    plasma = value['plasma'] ?? false;
    bed = value['bed'] ?? false;
    oxygen = value['oxygen'] ?? false;
    tablets = value['tablets'] ?? false;
    injection = value['injection'] ?? false;
    ventilator = value['ventilator'] ?? false;
    postId = value['postId'] ?? '';
    userId = value['userId'] ?? '';
    timestamp = value['timestamp'] ?? 0;
    timeDisplay = value['timedisplay'] ?? '';
  }
}
