import 'package:flutter/material.dart';
import '../widgets/myTab.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  String title = "Characters";

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
                expandedHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.35,
                pinned: true,
                title: Container(
                  padding: EdgeInsets.only(bottom: 5,top: 5,right: 10,left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black38,
                  ),
                  child: Text(title),
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "assets/rm.jpg",
                      fit: BoxFit.cover,
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
            MyTab(
              type: "Character",
              query: """
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
               """,
            ),
            MyTab(
              type: "Location",
              query: """
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
                     }
                   }
                 }
               }
               """,
            ),
            MyTab(
              type: "Episode",
              query: """
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
                     }
                   }
                 }
               }
               """,
            )
          ])),
    );
  }
}
