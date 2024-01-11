class DonorModel {
  String? name;
  String? age;
  String? place;
  String? phone;
  String? bloodGroup;
  String? image;

  DonorModel({
    required this.name,
    required this.age,
    required this.place,
    required this.bloodGroup,
    required this.phone,
    required this.image,
  });

  factory DonorModel.fromJson(Map<String,dynamic>json){
    return DonorModel(
      name: json["name"],
      age:  json["age"],
      place:  json["place"],
      bloodGroup:  json["bloodGroup"],
      phone: json["phone"],
      image:  json["image"]
        );
  }
  Map<String,dynamic>toJson(){
    return {
      "name":name,
      "age":age,
      "phone":phone,
      "bloodGroup":bloodGroup,
      "place":place,
      "image":image,
    };
  }
}
