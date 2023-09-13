class Users {
  final int id;
  final String name;
  final String email;
  final int is_online;

  Users({
      required this.id,
      required this.name,
      required this.email,
      required this.is_online,
  });

   factory Users.formJson(Map <String, dynamic> json){
    return new Users(
       id: json['id'],
       name: json['name'],
       email: json['email'],
       is_online: json['is_online'],
    );
  }

  
}
