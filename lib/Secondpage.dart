import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Seconapage extends StatefulWidget {
  const Seconapage({super.key});

  @override
  State<Seconapage> createState() => _SeconapageState();
}

class _SeconapageState extends State<Seconapage> {
  RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = 'ca-app-pub-3940256099942544/5224354917';

  /// Loads a rewarded ad.

  void loadAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            setState(() {
              _rewardedAd = ad;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ads"),
      ),
      body: ElevatedButton(
          onPressed: () {
            if (_rewardedAd != null) {
              _rewardedAd!.show(onUserEarnedReward:
                  (AdWithoutView ad, RewardItem rewardItem) {
                // Reward the user for watching an ad.
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Coin Collected")));
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Video Ads Not Availble")));
            }
          },
          child: Text("rewarded")),
    );
  }
}
