import 'dart:async';

import 'package:flutter/material.dart';

import 'launch_card_detailed.dart';
import 'launch_fetcher.dart';
import 'launch_models/launch_model.dart';

class LaunchCardPreview extends StatefulWidget {
  const LaunchCardPreview({Key key, this.launch, this.heroTag})
      : super(key: key);
  final Launch launch;
  final String heroTag;
  @override
  _LaunchCardPreviewState createState() => _LaunchCardPreviewState();
}

class _LaunchCardPreviewState extends State<LaunchCardPreview> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer =
        new Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  Widget displayShortDescription(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        children: [
          Text(
            widget.launch.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (widget.launch.windowStart.difference(DateTime.now()))
                .toString()
                .split('.')[0],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25),
          ),
          Container(
            height: 5,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withAlpha(75),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Agency: ${widget.launch.provider.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Status: ${widget.launch.status.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Mission: ${widget.launch.mission.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Rocket: ${widget.launch.rocket.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Pad: ${widget.launch.pad.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Type: ${widget.launch.provider.type}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Container(
            height: 5,
            margin: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark.withAlpha(75),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LaunchCardDetailed(
                        launch: widget.launch,
                        heroTag: widget.heroTag,
                      )));
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            clipBehavior: Clip.hardEdge,
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
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              children: [
                Hero(
                    tag: widget.launch.id + widget.heroTag,
                    child: LaunchFetcher.loadLaunchImage(
                        context, widget.launch.imageurl)),
                displayShortDescription(context),
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
