import 'package:flutter/material.dart';
import '../widgets/myTab.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  String title;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                pinned: true,
                title: Text(
                  getTitle(_tabController.index),
                ),
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                  "assets/rm.jpg",
                  fit: BoxFit.cover,
                )),
                bottom: TabBar(
                  labelPadding: EdgeInsets.only(bottom: 5),
                  tabs: [
                    Icon(
                      Icons.people,
                    ),
                    Icon(Icons.location_on),
                    Icon(Icons.movie)
                  ],
                  controller: _tabController,
                ),
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

String getTitle(int index) {
  if (index == 0)
    return 'Characters';
  else if (index == 1)
    return 'Locations';
  else if (index == 2)
    return 'Episodes';
  else
    throw ErrorHint('Invalid tab index');
}
