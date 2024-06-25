import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';
import 'package:wolt/views/venue_list.dart';

class VenuePage extends StatefulWidget {
  const VenuePage({super.key});

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<BaseViewmodel>().initializeFavorites();
      context.read<BaseViewmodel>().startCoordinateLooping();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 8.0,
          title: const Text(Constants.appBarText),
        ),
        body: const VenueList());
  }
}
