import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/myTab.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> characters;
  final List<Map<String, dynamic>> locations;
  final List<Map<String, dynamic>> episodes;

  HomePage({@required this.characters, @required this.locations, @required this.episodes});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  String title = "Characters";
  final characterQuery = """
               query GetCharacters{
                 characters {
                   results {
                     id
                     name
                     image
                     species
                     type
                     gender
                   }
                 }
               }
               """;
  final locationQuery = """
               query GetLocation{
                 locations {
                   results {
                     id
                     name
                     type
                     dimension
                     created
                     residents{
                       name
                     }
                   }
                 }
               }
               """;
  final episodeQuery = """
               query GetEpisode{
                 episodes {
                   results {
                     id
                     name
                     air_date
                     episode
                     created
                     characters{
                       name
                     }
                   }
                 }
               }
               """;
  String currentCharacterQuery;
  String currentLocationQuery;
  String currentEpisodeQuery;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0)
          title = "Characters";
        else if (_tabController.index == 1)
          title = "Locations";
        else if (_tabController.index == 2) title = "Episodes";
      });
    });
    currentCharacterQuery = characterQuery;
    currentLocationQuery = locationQuery;
    currentEpisodeQuery = episodeQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                pinned: true,
                title: Container(
                  padding: EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black38,
                  ),
                  child: Text(title),
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: CupertinoTextField(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xBBF0F1F5),
                        ),
                        placeholder: 'Search',
                        prefix: Padding(
                          padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (String enteredValue) {
                          setState(() {
                            if (_tabController.index == 0) {
                              if (enteredValue.isEmpty)
                                currentCharacterQuery = characterQuery;
                              else
                                currentCharacterQuery = """query SearchCharacter{
                                                             characters(filter: {name:"$enteredValue"}) {
                                                               results{
                                                                 id
                                                                 name
                                                                 image
                                                                 species
                                                                 type
                                                                 gender
                                                               }
                                                             }
                                                           }""";
                            } else if (_tabController.index == 1) {
                              if (enteredValue.isEmpty)
                                currentLocationQuery = locationQuery;
                              else
                                currentLocationQuery = """query SearchLocation{
                                                             locations(filter: {name:"$enteredValue"}) {
                                                               results{
                                                                  id
                                                                  name
                                                                  type
                                                                  dimension
                                                                  created
                                                                  residents{
                                                                    name
                                                                  }
                                                               }
                                                             }
                                                           }""";
                            } else {
                              if (enteredValue.isEmpty)
                                currentEpisodeQuery = episodeQuery;
                              else
                                currentEpisodeQuery = """query SearchEpisode{
                                                             episodes(filter: {episode:"$enteredValue"}) {
                                                               results{
                                                                 id
                                                                 name
                                                                 air_date
                                                                 episode
                                                                 created
                                                                 characters{
                                                                   name
                                                                 }
                                                               }
                                                             }
                                                           }""";
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/rm.jpg"),
                    fit: BoxFit.cover,
                  )),
                )),
                bottom: TabBar(
                  labelPadding: EdgeInsets.only(bottom: 5),
                  tabs: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black38,
                      ),
                      child: Icon(
                        Icons.people,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black38,
                      ),
                      child: Icon(Icons.location_on),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black38,
                      ),
                      child: Icon(Icons.movie),
                    ),
                  ],
                  controller: _tabController,
                ),
                actions: [],
              )
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            MyTab(type: "Character", query: currentCharacterQuery, ids: widget.characters ?? []),
            MyTab(type: "Location", query: currentLocationQuery, ids: widget.locations ?? []),
            MyTab(type: "Episode", query: currentEpisodeQuery, ids: widget.episodes ?? [])
          ])),
    );
  }
}
