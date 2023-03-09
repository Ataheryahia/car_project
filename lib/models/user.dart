class User {
  static int? _id;
  static String? _name;
  static String? _email;
  
  // static String? _phone;

  static void setUserData(int id , String name , String email ) {
    _id = id;
    _name = name;
    _email = email;
   
  }

  static int? getUserId() {
    return _id;
  }

  static String? getUserName() {
    return _name;
  }

  

  static String? getUserEmail() {
    return _email;
  }
  
}