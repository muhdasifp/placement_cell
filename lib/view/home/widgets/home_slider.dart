import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_hub/data/colors.dart';
import 'package:placement_hub/view/components/custom_shimmer.dart';

ValueNotifier<int> _homeSliderIndicator = ValueNotifier(0);

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('banners').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.docs;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    _homeSliderIndicator.value = index;
                  },
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  enlargeFactor: 0.4,
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                items: data
                    .map((e) => Image(
                          image: NetworkImage('${e['banner']}'),
                          fit: BoxFit.cover,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  data.length,
                  (index) => ValueListenableBuilder(
                    valueListenable: _homeSliderIndicator,
                    builder: (_, value, __) {
                      return Container(
                        height: 8,
                        width: value == index ? 25 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: value == index
                              ? AppColors.blueColor
                              : AppColors.greenColor,
                        ),
                        margin: const EdgeInsets.all(3),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  _homeSliderIndicator.value = index;
                },
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeFactor: 0.4,
                autoPlay: true,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              items: [
                CustomShimmer(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                ),
                CustomShimmer(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                ),
                CustomShimmer(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                ),
                // Image.network(
                //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdUetMl5z-OciMS0bYh3cH6wTZSODaq8E28w&s',
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                // ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => ValueListenableBuilder(
                  valueListenable: _homeSliderIndicator,
                  builder: (_, value, __) {
                    return Container(
                      height: 8,
                      width: value == index ? 18 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: value == index
                            ? AppColors.blueColor
                            : AppColors.greenColor,
                      ),
                      margin: const EdgeInsets.all(3),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
