
class User {
    String id;
    String username;
    String phone;
    String? address;

    User({
        required this.id,
        required this.username,
        required this.phone,
        this.address});

    factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username:data['username'] ,
        phone: data['phone'],
        address: data['address']);

    Map<String, dynamic> toMap() =>{
        'id':id,
        'username': username,
        'phone': phone,
        'address': address
    };
}