import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/news_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class NewsController extends GetxController {
  Box? box = Hive.box("data");
  static const String uploadEndPoint = '';
  static bool isLoading = false;
  static bool isRemoteCallCompleted = false;
  List<NewsModel> result = [];

  Future getSearchData(String q) async {
    // result.clear();
    if (isLoading) return;
    isLoading = true;
    isRemoteCallCompleted = false;

    final headers = {"Accept": "application/json"};
    try {
      var response =
          await http.get(Uri.parse(Constant.searchurl), headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        var res = jsonDecode(response.body);

        await box!.put("data", res);

        var json = res["articles"];

        //result = VideoFromJson(res["items"]);
        // print(result);
        for (var dd in json) {
          var da = NewsModel(
            title: dd["title"],
            description: dd["description"],
            source: dd["source"]["name"],
            url: dd["url"],
            image: dd["urlToImage"],
            date: dd["publishedAt"],
          );

          result.add(da);

          // print(dd["snippet"]["title"]);
        }

        // for( var data in result){
        //
        //   print(data.title);
        // }

      } else {
        print('Something went wrong!');
      }
    } catch (exception) {
      print('Something went wrong!2' + exception.toString());
      var res = await box!.get("data");

      var json = res["articles"];

      //result = VideoFromJson(res["items"]);
      // print(result);
      for (var dd in json) {
        var da = NewsModel(
          title: dd["title"],
          description: dd["description"] ?? "",
          source: dd["source"]["name"],
          url: dd["url"] ?? "",
          image: dd["urlToImage"] ??
              "https://www.hansacequity.com/wp-content/uploads/2022/07/placeholder-1-300x200.png",
          date: dd["publishedAt"],
        );

        result.add(da);

        // print(dd["snippet"]["title"]);
      }
    }
    isLoading = false;

    isRemoteCallCompleted = true;

    update();
    return result;
  }
}
