import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'launch_card_preview.dart';
import 'launch_data_store.dart';

class LaunchList extends StatefulWidget {
  const LaunchList({
    Key key,
  }) : super(key: key);

  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: context.read<LaunchDataStore>().loadLaunches(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<LaunchDataStore>(
                builder: (context, launchDataStore, child) {
              return (launchDataStore.launches.length > 0)
                  ? ListView.builder(
                      itemCount: launchDataStore.launches.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LaunchCardPreview(
                          launch: launchDataStore.launches.elementAt(index),
                          heroTag: "list",
                        );
                      })
                  : Center(
                      child: Text(
                          "You don't have any followed launches\n\nStart searching by swiping left",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2),
                    );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
