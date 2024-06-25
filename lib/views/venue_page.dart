import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';
import 'package:wolt/views/venue_list.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BaseViewmodel>().initializeFavorites();
    context.read<BaseViewmodel>().startCoordinateLooping();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 8.0,
          title: const Text(Constants.appBarText),
        ),
        body: const VenueList());
  }
}
