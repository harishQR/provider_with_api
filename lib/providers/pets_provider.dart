import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/pets.dart';
class petsProvider extends ChangeNotifier{
 static const apiEndPoint =
     "https://jatinderji.github.io/users_pets_api/users_pets.json";
   bool isloading = true;
   String error = '';
   Pets pets = Pets(data:[]);
   Pets searchedPets = Pets(data: []);
   String searchtext ="";
   getDataFromAPI()async{
     try{
      Response response = await http.get(Uri.parse(apiEndPoint));
      if(response.statusCode == 200){
        pets = petsFromJson(response.body);
      }else{
        error = response.statusCode.toString();
      }
     }
     catch(e){
     error = e.toString();
     }
     isloading = false;
     updatedata();
   }
   updatedata(){
     searchedPets.data.clear();
      if(searchtext.isEmpty){
        searchedPets.data.addAll(pets.data);
      }
      else{
        searchedPets.data.addAll(pets.data.where((element) => element.userName.toLowerCase().startsWith(searchtext)).toList());
      }
      notifyListeners();
   }
  search(String username){
     searchtext = username;
     updatedata();
  }
}
