import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LaunchFetcher {
  static String apipath = 'lldev.thespacedevs.com';
  static String apiversion = '/2.2.0/launch/upcoming/';
  static Future<Response> fetchLaunch(
      int offset, int searchLimit, String searchTerm) async {
    Map<String, String> searchParameters = {
      "limit": searchLimit.toString(),
      "offset": offset.toString(),
      "search": searchTerm
    };

    return http.get(Uri.https(apipath, apiversion, searchParameters));
  }

  static Future<Response> fetchLaunchByID(String launchid) async {
    return await http.get(Uri.https(apipath, apiversion + launchid + '/'));
  }

  static Widget loadLaunchImage(BuildContext context, String url) {
    if (url != null) {
      return Image.network(
        url,
        loadingBuilder: (context, child, loading) {
          if (loading == null) {
            return child;
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        width: double.infinity,
        fit: BoxFit.fitWidth,
      );
    } else {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          height: 50,
          child: Text("No image", style: Theme.of(context).textTheme.bodyText2),
        ),
      );
    }
  }
}
