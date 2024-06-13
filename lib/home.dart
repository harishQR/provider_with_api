import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_api/models/pets.dart';
import 'package:provider_with_api/providers/pets_provider.dart';
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<petsProvider>(context);
    provider.getDataFromAPI();
    return Scaffold(
      body: provider.isloading ? getLoadingUI() :
      provider.error.isNotEmpty ? getErrorUI(provider.error):
      getBodyUI(context),
    );
  }

Widget  getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 50,
          ),
          Text("Loading.."),

        ],
      ),
    );
  }

Widget  getErrorUI(String error) {
return Center(
  child: Text(error,style: const TextStyle(color: Colors.red,fontSize: 22),) ,
);
  }

Widget  getBodyUI(BuildContext context) {
  final provider = Provider.of<petsProvider>(context,listen: false);
return Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (value){
          provider.search(value);
        },
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
    Expanded(
      child: Consumer (builder: (context,petsProvider PetsProvider,child) => ListView.builder(itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(PetsProvider.searchedPets.data[index].petImage)),
          title: Text(PetsProvider.searchedPets.data[index].userName),
          trailing: PetsProvider.searchedPets.data[index].isFriendly ? const SizedBox() : Icon(Icons.pets,color: Colors.red,),
        ),
      ) ,itemCount: PetsProvider.searchedPets.data.length,),
    ),),
  ],
);
  }
}
