import 'dart:async';

import 'package:flutter/material.dart';

import 'launch_fetcher.dart';
import 'launch_models/launch_model.dart';
import 'launch_data_store.dart';
import 'package:provider/provider.dart';

class LaunchCardDetailed extends StatefulWidget {
  const LaunchCardDetailed({Key key, this.launch, this.heroTag})
      : super(key: key);

  final Launch launch;
  final String heroTag;
  @override
  _LaunchCardDetailedState createState() => _LaunchCardDetailedState();
}

class _LaunchCardDetailedState extends State<LaunchCardDetailed> {
  bool followed = false;

  Timer timer;
  Color textHighlight = Colors.white.withAlpha(235);

  @override
  void initState() {
    super.initState();
    timer =
        new Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  Widget followUnfollowButton() {
    final launchDataStore = context.read<LaunchDataStore>();

    if (followed) {
      return GestureDetector(
        onTap: () {
          launchDataStore.removeLaunch(widget.launch);
          setState(() {
            followed = false;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text(
              "Unfollow",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          launchDataStore.addLaunch(widget.launch);
          setState(() {
            followed = true;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
              color: Color.fromRGBO(121, 149, 90, 1),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text(
              "Follow",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      );
    }
  }

  Widget launchNameTimeCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            Text(
              widget.launch.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              (widget.launch.windowStart.difference(DateTime.now()))
                  .toString()
                  .split('.')[0],
              textAlign: TextAlign.center,
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget launchProviderCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              widget.launch.provider.name,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20, color: textHighlight),
            ),
          ),
          Table(
            children: [
              TableRow(children: [
                Text(
                  "Type",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.provider.type,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }

  Widget launchStatusCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Launch status",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20, color: textHighlight),
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    "Status",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: textHighlight),
                  ),
                  Text(
                    widget.launch.status.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              TableRow(children: [
                Text(
                  "Abbreviation",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.status.abbrev,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: textHighlight),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.launch.status.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  Widget missionCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Mission",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20, color: textHighlight),
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    "Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: textHighlight),
                  ),
                  Text(
                    widget.launch.mission.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              TableRow(children: [
                Text(
                  "Type",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.mission.type,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
              TableRow(children: [
                Text(
                  "Orbit",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.mission.orbitname,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
              TableRow(children: [
                Text(
                  "Orbit Abbrev.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.mission.orbitabbrev,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: textHighlight),
              ),
            ),
          ),
          Text(
            widget.launch.mission.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget rocketCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Rocket",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20, color: textHighlight),
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  Text(
                    "Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: textHighlight),
                  ),
                  Text(
                    widget.launch.rocket.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              TableRow(children: [
                Text(
                  "Full name",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.rocket.fullname,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
              TableRow(children: [
                Text(
                  "Family",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.rocket.family,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
              TableRow(children: [
                Text(
                  "Variant",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: textHighlight),
                ),
                Text(
                  widget.launch.rocket.variant,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget launchPadCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
            child: Text(
              "Pad",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20, color: textHighlight),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorDark.withAlpha(200),
            margin: EdgeInsets.only(bottom: 20),
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 10,
              child: LaunchFetcher.loadLaunchImage(
                  context, widget.launch.pad.padlocationimgurl),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 10),
            child: Column(
              children: [
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          "Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: textHighlight),
                        ),
                        Text(
                          widget.launch.pad.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    TableRow(children: [
                      Text(
                        "Pad location",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.locationname,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Latitude",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.latitude,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Longitude",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.longitude,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Pad launches",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.launchcount.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 5,
                    ),
                    child: Text(
                      "Location information",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: textHighlight),
                    ),
                  ),
                ),
                Table(
                  children: [
                    TableRow(children: [
                      Text(
                        "Location name",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.locationname,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Country code",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.locationcc,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Location launches",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.locationlaunchcount.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "Location lands",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: textHighlight),
                      ),
                      Text(
                        widget.launch.pad.locationlaunchcount.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayDetailedDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          launchNameTimeCard(),
          launchProviderCard(),
          launchStatusCard(),
          missionCard(),
          rocketCard(),
          launchPadCard(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    followed = context.read<LaunchDataStore>().containsLaunch(widget.launch);
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Hero(
              tag: widget.launch.id + widget.heroTag,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: LaunchFetcher.loadLaunchImage(
                      context, widget.launch.imageurl))),
          followUnfollowButton(),
          displayDetailedDescription(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
