import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
class dynamicLinksService{
  static Future<void> generateDynamicLink(bool short) async{
    String _linkedMessage;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://thebargym.page.link',
      link: Uri.parse('https://www.spacemulecode.com/deeplink?id=demo'),
      androidParameters: AndroidParameters(
        packageName: "com.example.the_bar_gym",
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        fallbackUrl: Uri.parse("https://www.spacemulecode.com"),
        bundleId: "com.example.the_bar_gym",
        minimumVersion: '2',
      ),
    );
    Uri url;
    if(short){
      final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
      url=shortDynamicLink.shortUrl;
    }else{
      url=await parameters.buildUrl();
    }

    _linkedMessage=url.toString();
    print(_linkedMessage);
  }
  static Future<void> initDynamicLink() async{
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;
          print("deeplink found");

          if (deepLink != null) {
            String? id=deepLink.queryParameters['id'];
            print(deepLink);
          }else{
            return null;
          }
        }, onError: (OnLinkErrorException e) async {
      print("deeplink error");
      print(e.message);
    });
  }
}