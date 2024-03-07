
class User {
    int id;
    String fullName;
    String phone;
    String? avatar;
    double averageRating;
    String? address;


    User({required this.id, required this.fullName, required this.phone, this.avatar, required this.averageRating,this.address});

    factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        fullName:data['fullName'] ,
        phone: data['phone'],
        avatar: data['avatar'],
        averageRating: data['averageRating'],
        address: data['address']);

    Map<String, dynamic> toMap() =>{
        'id':id,
        'fullName': fullName,
        'phone': phone,
        'avatar': avatar,
        'averageRating':averageRating,
        'address': address
    };
}