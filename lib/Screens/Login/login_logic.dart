class LoginLogic{


  pass(password){
    print(password);
  }

  bool login(String phoneNumber, String password){
    if(phoneNumber == "321" && password == "123"){
      print("ura ura");
      return true;
    }
    else {
      print("you entered wrong login or password");
      return false;
    }
  }
}