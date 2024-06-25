import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/components/item_component.dart';
import 'package:wolt/models/section_model.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';

class VenueList extends StatelessWidget {
  const VenueList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<BaseViewmodel>();
    print('rebuilding');
    return ListView.separated(
      itemBuilder: (_, index) {
        List<SectionModel>? sections = viewModel.getSections();
        print(
            '${sections![1].items[index].venue.id}: ${sections[1].items[index].venue.isFavorite}');
        return ItemComponent(
          imageURL: sections![1].items[index].image.imageURL,
          venueName: sections[1].items[index].venue.name,
          shortDescription: sections[1].items[index].venue.shortDescription,
          venueId: sections[1].items[index].venue.id,
          isFavorite: sections[1].items[index].venue.isFavorite,
        );
      },
      itemCount: 15,
      separatorBuilder: (_, __) => Padding(
        padding: EdgeInsets.only(right: 16, left: width * 0.25),
        child: const Divider(),
      ),
    );
  }
}
