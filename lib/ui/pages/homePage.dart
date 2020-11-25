import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'charactersPage.dart';
import 'episodesPage.dart';
import 'locationsPage.dart';

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
  String currentCharacterQuery;
  String currentLocationQuery;
  String currentEpisodeQuery;
  String characterFilter = "name";
  String locationFilter = "name";
  String episodeFilter = "name";
  List<PopupMenuEntry<String>> popUpMenu;
  List<PopupMenuEntry<String>> defaultPopUp = [
    PopupMenuItem(value: "name", child: Text('Name')),
    PopupMenuItem(value: "gender", child: Text('Gender')),
    PopupMenuItem(value: "species", child: Text('Species')),
  ];
  List<Map<String, dynamic>> starredCharacters;
  List<Map<String, dynamic>> starredLocations;
  List<Map<String, dynamic>> starredEpisodes;
  final characterQuery = """
               query GetCharacters{
                 characters {
                   results {
                     id
                     name
                     status
                     species
                     type
                     gender
                     origin{
                       id
                       name
                     }
                     location{
                       id
                       name
                     }
                     image
                     episode{
                       id
                       name
                       episode
                     }
                     created
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
                       id
                       name
                       status
                       species
                       type
                       gender
                       image
                       created
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
                       id
                       name
                       status
                       species
                       type
                       gender
                       origin{
                         id
                       }
                       location{
                         id
                       }
                       image
                       episode{
                         id
                         name
                         episode                 
                       }
                       created
                     }
                   }
                 }
               }
               """;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    popUpMenu = defaultPopUp;
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          title = "Characters";
          popUpMenu = defaultPopUp;
        } else if (_tabController.index == 1) {
          title = "Locations";
          popUpMenu = [
            PopupMenuItem(value: "name", child: Text('Name')),
            PopupMenuItem(value: "type", child: Text('Type')),
          ];
        } else if (_tabController.index == 2) {
          title = "Episodes";
          popUpMenu = [
            PopupMenuItem(value: "name", child: Text('Name')),
            PopupMenuItem(value: "episode", child: Text('Episode')),
          ];
        }
      });
    });
    currentCharacterQuery = characterQuery;
    currentLocationQuery = locationQuery;
    currentEpisodeQuery = episodeQuery;
    starredCharacters = widget.characters;
    starredLocations = widget.locations;
    starredEpisodes = widget.episodes;
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 90),
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
                        suffix: PopupMenuButton<String>(
                          onSelected: (String selected) {
                            setState(() {
                              if (_tabController.index == 0)
                                characterFilter = selected;
                              else if (_tabController.index == 1)
                                locationFilter = selected;
                              else if (_tabController.index == 2) episodeFilter = selected;
                            });
                          },
                          color: Color(0xBBF0F1F5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          itemBuilder: (BuildContext context) {
                            return popUpMenu;
                          },
                        ),
                        onChanged: (String enteredValue) {
                          setState(() {
                            if (_tabController.index == 0) {
                              if (enteredValue.isEmpty)
                                currentCharacterQuery = characterQuery;
                              else
                                currentCharacterQuery = """query SearchCharacter{
                                                             characters(filter: {$characterFilter:"$enteredValue"}) {
                                                               results{
                                                                 id
                                                                 name
                                                                 status
                                                                 species
                                                                 type
                                                                 gender
                                                                 origin{
                                                                   id
                                                                   name
                                                                 }
                                                                 location{
                                                                   id
                                                                   name
                                                                 }
                                                                 image
                                                                 episode{
                                                                   id
                                                                   name
                                                                   episode
                                                                 }
                                                                 created                   
                                                               }
                                                             }
                                                           }""";
                            } else if (_tabController.index == 1) {
                              if (enteredValue.isEmpty)
                                currentLocationQuery = locationQuery;
                              else
                                currentLocationQuery = """query SearchLocation{
                                                             locations(filter: {$locationFilter:"$enteredValue"}) {
                                                               results{
                                                                  id
                                                                  name
                                                                  type
                                                                  dimension
                                                                  created
                                                                  residents{
                                                                    id
                                                                    name
                                                                    status
                                                                    species
                                                                    type
                                                                    gender
                                                                    image                                                                    
                                                                    created
                                                                  }
                                                               }
                                                             }
                                                           }""";
                            } else {
                              if (enteredValue.isEmpty)
                                currentEpisodeQuery = episodeQuery;
                              else
                                currentEpisodeQuery = """query SearchEpisode{
                                                             episodes(filter: {$episodeFilter:"$enteredValue"}) {
                                                               results{
                                                                 id
                                                                 name
                                                                 air_date
                                                                 episode
                                                                 created
                                                                 characters{
                                                                   id
                                                                   name
                                                                   status
                                                                   species
                                                                   type
                                                                   gender
                                                                   image    
                                                                   created
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
            CharactersPage(
              query: currentCharacterQuery,
              ids: starredCharacters ?? [],
              onIdsChanged: (ids) {
                setState(() {
                  starredCharacters = ids;
                });
              },
            ),
            LocationsPage(
              query: currentLocationQuery,
              ids: starredLocations ?? [],
              onIdsChanged: (ids) {
                setState(() {
                  starredLocations = ids;
                });
              },
            ),
            EpisodesPage(
              query: currentEpisodeQuery,
              ids: starredEpisodes ?? [],
              onIdsChanged: (ids) {
                setState(() {
                  starredEpisodes = ids;
                });
              },
            )
          ])),
    );
  }
}
