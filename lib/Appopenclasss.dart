import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppOpenAd _appOpenAd;

  NativeAd? nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    // Initialize the Google Mobile Ads SDK
    MobileAds.instance.initialize().then((InitializationStatus status) {
      // Load App Open Ad
      _loadAppOpenAd();

      loadAd();
    });
  }

  String appopenadUnitId =  'ca-app-pub-3940256099942544/9257395921';


  void _loadAppOpenAd() {
    // Load an App Open Ad
    AppOpenAd.load(
      adUnitId: appopenadUnitId,
      // adUnitId: appOpenAdUnitId,
      request: AdRequest(),
      orientation: AppOpenAd.orientationPortrait,
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _appOpenAd = ad;
          });
          showAppOpenAdIfAvailable();
        },
        onAdFailedToLoad: (error) {
          print('App Open Ad failed to load: $error');
        },
      ),
    );
  }

  void showAppOpenAdIfAvailable() {
    if (_appOpenAd != null) {
      _appOpenAd.show();
    }
  }

  @override
  void dispose() {
    _appOpenAd?.dispose();
    super.dispose();
  }



  // TODO: replace this test ad unit with your own ad unit.
  final String _adUnitId =   'ca-app-pub-3940256099942544/3986624511';

  /// Loads a native ad.
  void loadAd() {
    nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request:  AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(body: ConstrainedBox(
     constraints:  BoxConstraints(
       minWidth: 320, // minimum recommended width
       minHeight: 320, // minimum recommended height
       maxWidth: 400,
       maxHeight: 400,
     ),
     child: AdWidget(ad: nativeAd!),
   ),);
  }





// Medium template
//   final adContainer = ConstrainedBox(
//     constraints: const BoxConstraints(
//       minWidth: 320, // minimum recommended width
//       minHeight: 320, // minimum recommended height
//       maxWidth: 400,
//       maxHeight: 400,
//     ),
//     child: AdWidget(ad: nativeAd!),
//   );
}
