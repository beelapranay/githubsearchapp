import 'dart:convert';
import 'package:githubapi/views/searchresult.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:githubapi/models/usermodel.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();
  TextStyle style = GoogleFonts.raleway(fontSize: 16,color: Colors.deepPurple);
  TextStyle stylem = GoogleFonts.raleway(fontSize: 16,color: Colors.deepPurple,fontWeight: FontWeight.w300);
  TextStyle styleh = GoogleFonts.raleway(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold);
  String name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text("Github Search", style: GoogleFonts.raleway(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
        ),
        backgroundColor: Colors.deepPurple,
        body: Container(
          padding: EdgeInsets.all(12),
            child: Column(
              children: [

                Container(
                  height: 300,
                  width: 300,
                  child: Image.asset('images/git.png'),
                ),

                SizedBox(height: 35,),

                Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        maxLines: null,
                        style: GoogleFonts.raleway(fontSize: 16,color: Colors.deepPurple),
                        onSaved: (val) => name = val,
                        cursorColor: Colors.deepPurple,
                        cursorWidth: 1,
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search for People...",
                          hintStyle: style,
                          border: InputBorder.none
                        ),
                      ),
                    ),

                SizedBox(
                  height: 15
                ),

                OutlineButton(
                    onPressed: (){
                      searchController.text.isEmpty ? null :
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResults(name: searchController.text),
                          ));
                      setState(() {
                        searchController.text == "";
                      });
                    },
                  borderSide: BorderSide(color: Colors.white),
                  highlightedBorderColor: Colors.white,
                  child: Text("Search", style: GoogleFonts.raleway(color: Colors.white,fontSize: 18),),
                    ),

              ],
            ),
          ),
        ),
      );
  }
}
