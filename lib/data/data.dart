class Data {
  String uid;
  String title;
  String shortDescription;
  String description;
  String organizer;
  String adress;

  Data(this.uid,this.title, this.description, this.organizer, this.adress,
      this.shortDescription);

  Data copy() {
    return Data(this.uid, this.title, this.description, this.organizer,
        this.adress, this.shortDescription);
  }
   Map<String, dynamic> toMap(){
    return {
      "title": title,
      "description": description,
      "shortDescription": shortDescription,
      "organizer": organizer,
      "uid": uid,
      "adress": adress,
    };
  }
}

