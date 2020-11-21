import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:githubapi/models/usermodel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResults extends StatefulWidget {
  final String name;
  SearchResults({Key key, @required this.name}) : super(key: key);
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  Future<UserModel> fetchDetails(name) async {
    if(name==null){
      return null;
    }
    else{
      final response = await http.get('https://api.github.com/users/'+name.trim());
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user details');
      }
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 25,),
                onPressed: (){
              Navigator.pop(context);
                }),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              title: Text(widget.name, style: GoogleFonts.raleway(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
          ),
        backgroundColor: Colors.deepPurple,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: FutureBuilder<UserModel>(
                future: fetchDetails(widget.name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [

                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurple,width: 2),
                              image: new DecorationImage(
                                image: new NetworkImage(snapshot.data.avatarUrl),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                          ),

                          SizedBox(height: 10,),

                          snapshot.data.bio == null ? SizedBox(height: 0,) :Text(
                              snapshot.data.bio,style: GoogleFonts.raleway(
                              fontSize: 16,fontWeight: FontWeight.w500,color: Colors.deepPurple
                          )),

                          SizedBox(height: 10,),

                          snapshot.data.following == null ? SizedBox(height: 0,) :Text(
                              "👤 "+snapshot.data.following.toString()+" Following",style: GoogleFonts.raleway(
                              fontSize: 16,fontWeight: FontWeight.w500,color: Colors.deepPurple
                          )),

                          SizedBox(height: 10,),

                          snapshot.data.followers == null ? SizedBox(height: 0,) :Text(
                              "👥 "+snapshot.data.followers.toString()+" Follower (s)",style: GoogleFonts.raleway(
                              fontSize: 16,fontWeight: FontWeight.w500,color: Colors.deepPurple
                          )),

                          SizedBox(height: 10,),

                          snapshot.data.location == null ? SizedBox(height: 0,) :Text(
                              "📍 "+snapshot.data.location,style: GoogleFonts.raleway(
                              fontSize: 16,fontWeight: FontWeight.w500,color: Colors.deepPurple
                          )),

                          SizedBox(height: 5,),

                          Text("Joined: "+DateFormat.yMMMd().format(snapshot.data.createdAt),style: GoogleFonts.raleway(
                              fontSize: 16,fontWeight: FontWeight.w500,color: Colors.deepPurple
                          )),

                          SizedBox(height: 10,),

                          snapshot.data.publicRepos == null ? SizedBox(height: 0,) :
                          Row(
                            children: [

                              Icon(Icons.library_books,color: HexColor("#373737"),),

                              SizedBox(width: 5,),

                              GestureDetector(
                                onTap: (){
                                  _launchURL("https://github.com/"+snapshot.data.login+"/repositories");
                                },
                                child: Container(
                                  child: Text(
                                      "Public Repos: "+snapshot.data.publicRepos.toString(),style: GoogleFonts.raleway(
                                      fontSize: 16,fontWeight: FontWeight.w500,color: HexColor('#373737'),
                                      decoration: TextDecoration.underline
                                  )),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),

                          snapshot.data.twitterUsername == null ? SizedBox(height: 0,) :
                          Row(
                            children: [

                              Container(
                                height: 25,
                                width: 25,
                                child: Image.asset("images/twitter.png"),
                              ),

                              SizedBox(width: 5,),

                              GestureDetector(
                                onTap: (){
                                  _launchURL("https://twitter.com/"+snapshot.data.twitterUsername);
                                },
                                child: Container(
                                  child: Text(
                                      snapshot.data.twitterUsername,style: GoogleFonts.raleway(
                                      fontSize: 16,fontWeight: FontWeight.w500,color: HexColor('#128CE4'),
                                    decoration: TextDecoration.underline
                                  )),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),

                          Row(
                            children: [

                              Container(
                                height: 25,
                                width: 25,
                                child: Image.asset("images/github.png"),
                              ),

                              SizedBox(width: 5,),

                              GestureDetector(
                                onTap: (){
                                  _launchURL("https://github.com/"+snapshot.data.login);
                                },
                                child: Text(
                                    snapshot.data.login,style: GoogleFonts.raleway(
                                    fontSize: 16,fontWeight: FontWeight.w500,color: HexColor('#373737'),
                                  decoration: TextDecoration.underline
                                )),
                              ),
                            ],
                          ),

                        ],
                      ),
                    );

                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            "404", style: GoogleFonts.raleway(fontWeight: FontWeight.bold,fontSize: 60,color: Colors.white),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "User Not Found.", style: GoogleFonts.raleway(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                  return Text("");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
