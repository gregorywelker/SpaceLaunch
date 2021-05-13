import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'launch_card_preview.dart';
import 'launch_fetcher.dart';
import 'launch_models/launch_model.dart';
import 'package:provider/provider.dart';

import 'launch_data_store.dart';

class LaunchSearch extends StatefulWidget {
  const LaunchSearch({
    Key key,
  }) : super(key: key);

  @override
  _LaunchSearchState createState() => _LaunchSearchState();
}

class _LaunchSearchState extends State<LaunchSearch>
    with AutomaticKeepAliveClientMixin {
  TextEditingController textEditingController = new TextEditingController();
  ScrollController searchListController = new ScrollController();

  List<Launch> launches = [];
  Timer timer;
  int searchOffset = 0;
  int searchLimit = 10;
  bool hasLaunchLeft = true;
  String prevSearchWord = "";

  Future<void> handleSearchInput() async {
    if (textEditingController.text != prevSearchWord) {
      if (timer != null && timer.isActive) {
        timer.cancel();
      }
      setState(() {
        launches = [];
      });
      if (textEditingController.text.isNotEmpty) {
        timer = Timer(Duration(milliseconds: 750), () async {
          if (textEditingController.text.isNotEmpty) {
            searchOffset = 0;
            hasLaunchLeft = true;
            LaunchFetcher.fetchLaunch(
                    searchOffset, 10, textEditingController.text)
                .then((response) {
              prevSearchWord = textEditingController.text;
              if (response.statusCode == 200) {
                List<Launch> fetchedLaunches =
                    (jsonDecode(response.body)["results"] as List)
                        .map((i) => Launch.fromJson(i))
                        .toList();

                removeFollowedLaunches();
                setState(() {
                  launches = fetchedLaunches;
                });
              }
            });
          }
        });
      }
    }
  }

  void loadSearchListOnScroll() {
    if (searchListController.position.extentAfter < 100) {
      searchOffset += searchLimit;
      LaunchFetcher.fetchLaunch(searchOffset, 10, textEditingController.text)
          .then((response) {
        if (response.statusCode == 200) {
          List<Launch> fetchedLaunches =
              (jsonDecode(response.body)["results"] as List)
                  .map((i) => Launch.fromJson(i))
                  .toList();

          if (fetchedLaunches.length < searchLimit) {
            hasLaunchLeft = false;
          }

          List<Launch> temp = [];
          temp.addAll(launches);
          temp.addAll(fetchedLaunches);
          removeFollowedLaunches();
          setState(() {
            launches = temp;
          });
        }
      });
    }
  }

  removeFollowedLaunches() {
    List<Launch> followedLaunches = context.read<LaunchDataStore>().launches;
    for (var i = 0; i < launches.length; i++) {
      for (var j = 0; j < followedLaunches.length; j++) {
        if (followedLaunches[j].id == launches[i].id) {
          launches.remove(launches[i]);
        }
      }
    }
  }

  Widget displaySearchList() {
    if (timer != null && timer.isActive) {
      return Center(child: CircularProgressIndicator());
    }

    return (launches.length <= 0)
        ? Center(child: Text("No search result"))
        : ListView.builder(
            controller: searchListController,
            itemCount: launches.length,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Container(
                      padding: EdgeInsets.only(top: 90),
                      child: LaunchCardPreview(
                        launch: launches.elementAt(index),
                        heroTag: "search",
                      ))
                  : !hasLaunchLeft && index >= launches.length - 1
                      ? Container(
                          child: Column(
                          children: [
                            LaunchCardPreview(
                              launch: launches.elementAt(index),
                              heroTag: "search",
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text("No more launches")
                          ],
                        ))
                      : LaunchCardPreview(
                          launch: launches.elementAt(index),
                          heroTag: "search",
                        );
            },
          );
  }

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(handleSearchInput);
    searchListController.addListener(loadSearchListOnScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        displaySearchList(),
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 30),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: 'Search by agency, rocket model, etc...'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
