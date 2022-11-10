import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialx/controller/news_controller.dart';
import 'package:jiffy/jiffy.dart';
import 'package:socialx/pages/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<NewsController>();
  Box? box = Hive.box("data");

  @override
  void initState() {
    // TODO: implement initState

    myinit();
  }

  void myinit() async {
    // await controller.setProgress(context);
    await controller.getSearchData("");
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.blue, systemNavigationBarColor: Colors.blue);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.blue, fontSize: 24),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                            shadows: [
                              Shadow(color: Colors.blue, blurRadius: 3)
                            ],
                            size: 30,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0)),
                          hintText: "Search in feed",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await box!.put("login", false);
                        Route route = MaterialPageRoute(
                            builder: (context) => const SignupPage());
                        Navigator.push(context, route);
                      },
                    ),
                  ),
                )
              ],
            ),
            GetBuilder<NewsController>(builder: (_) {
              return Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 10.0, right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Route route = MaterialPageRoute(
                          //     builder: (context) => WebviewPage(
                          //         url: controller.result[index].url));
                          // Navigator.push(context, route);
                        },
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        timeConvert(
                                            controller.result[index].date),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 130, 130)),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        controller.result[index].source,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 133, 130, 130)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.result[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              controller
                                                  .result[index].description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    215, 63, 143, 204),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CachedNetworkImage(
                                        errorWidget: (_, url, error) {
                                          return Container(
                                            width: 90,
                                            height: 90,
                                            color: Colors.grey,
                                          );
                                        },
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            controller.result[index].image)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.result.length,
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  timeConvert(tt) {
    return Jiffy(tt).fromNow();
  }
}
