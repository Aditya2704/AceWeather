import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ace_weather/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:ace_weather/config/config.dart' as config;

TextStyle getClockStyle() {
  return const TextStyle(
      fontSize: 90.0, fontFamily: 'Digital', color: Colors.white);
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
            extendBody: true,
            backgroundColor: config.backgroundColor,
            body:
                SafeArea(child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: config.accentTextColor,
                                size: 20.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                model.isLoading ? "-" : model.userLocation,
                                style: const TextStyle(
                                    color: config.accentTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${model.currentTime["hours"]}',
                                style: getClockStyle(),
                              ),
                              const SizedBox(width: 5.0),
                              const BlinkingAnimation(),
                              const SizedBox(width: 5.0),
                              Text(
                                '${model.currentTime["minutes"]}',
                                style: getClockStyle(),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            '${model.currentDate}, ${model.currentDay}',
                            style: const TextStyle(
                                color: config.accentTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                                builder: (context, subconstraints) {
                              return Container(
                                height: subconstraints.maxHeight,
                                width: subconstraints.maxWidth,
                                color: config.secondaryBackgroundColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    !model.isLoading
                                        ? SizedBox(
                                            width: subconstraints.maxWidth,
                                            child: Icon(
                                              model.getIconData(
                                                  model.currentWeather[
                                                      "weatherIcon"]),
                                              size:
                                                  subconstraints.maxWidth * 0.3,
                                              color: config.accentTextColor,
                                            ),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    AutoSizeText(
                                      '${model.isLoading ? "-" : model.currentWeather["temp"]}',
                                      style: const TextStyle(
                                          fontSize: 60.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    AutoSizeText(
                                      model.isLoading
                                          ? "-"
                                          : '${model.currentWeather["maxTemp"]} | ${model.currentWeather["minTemp"]}  ${model.currentWeather["weatherDescription"]}',
                                      style: const TextStyle(
                                          color: config.accentTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    AutoSizeText(
                                      model.isLoading
                                          ? "-"
                                          : 'Feels ${model.currentWeather["feelsLikeTemp"]}',
                                      style: const TextStyle(
                                          color: config.accentTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    // model.currentWeather["hourlyForecast"]
                                    //             .length >
                                    //         0
                                    //     ? Row(
                                    //         children: [
                                    //           ...model.currentWeather[
                                    //                   "hourlyForecast"]
                                    //               .map((item) => Expanded(
                                    //                     child: Column(
                                    //                       children: [
                                    //                         Container(
                                    //                           child:
                                    //                               AutoSizeText(
                                    //                             '${item["weatherDescription"]}',
                                    //                             style: TextStyle(
                                    //                                 fontSize:
                                    //                                     15.0,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w500,
                                    //                                 color: config
                                    //                                     .secondaryAccentTextColor),
                                    //                             maxLines: 1,
                                    //                           ),
                                    //                         ),
                                    //                         Container(
                                    //                           child:
                                    //                               AutoSizeText(
                                    //                             '${item["temp"]}',
                                    //                             style: TextStyle(
                                    //                                 fontSize:
                                    //                                     17.0,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w500,
                                    //                                 color: config
                                    //                                     .secondaryAccentTextColor),
                                    //                             maxLines: 1,
                                    //                           ),
                                    //                         ),
                                    //                         SizedBox(
                                    //                           height: 2.0,
                                    //                         ),
                                    //                         Container(
                                    //                           child:
                                    //                               AutoSizeText(
                                    //                             '${item["date"]}',
                                    //                             style: TextStyle(
                                    //                                 fontSize:
                                    //                                     14.0,
                                    //                                 color: config
                                    //                                     .secondaryAccentTextColor),
                                    //                             maxLines: 1,
                                    //                           ),
                                    //                         )
                                    //                       ],
                                    //                     ),
                                    //                   ))
                                    //         ],
                                    //       )
                                    //     : Container()
                                  ],
                                ),
                              );
                            }),
                          ),
                          Expanded(child:
                              LayoutBuilder(builder: (context, subconstraints) {
                            return Center(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: model.futureForecast.length,
                                itemBuilder: (context, index) {
                                  final item = model.futureForecast[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            subconstraints.maxHeight * 0.02),
                                    child: Column(
                                      children: [
                                        item["weatherIcon"] != ""
                                            ? SizedBox(
                                                width: subconstraints.maxWidth,
                                                child: Icon(
                                                    model.getIconData(
                                                        item["weatherIcon"]),
                                                    size: subconstraints
                                                            .maxWidth *
                                                        0.15,
                                                    color: config
                                                        .secondaryAccentTextColor),
                                              )
                                            : Container(),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        AutoSizeText(
                                          '${item["temp"]} ${item["weatherDescription"]}',
                                          style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w500,
                                              color: config
                                                  .secondaryAccentTextColor),
                                          maxLines: 1,
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        AutoSizeText(
                                          '${item["date"]}',
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: config
                                                  .secondaryAccentTextColor),
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Divider(
                                      color: config.secondaryAccentTextColor
                                          .withOpacity(0.7),
                                    ),
                                  );
                                },
                              ),
                            );
                          })),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }))));
  }
}

class BlinkingAnimation extends StatefulWidget {
  const BlinkingAnimation({Key? key}) : super(key: key);

  @override
  _BlinkingAnimationState createState() => _BlinkingAnimationState();
}

class _BlinkingAnimationState extends State<BlinkingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        ':',
        style: getClockStyle(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
