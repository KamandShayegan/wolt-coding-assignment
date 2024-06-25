import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/components/item_component.dart';
import 'package:wolt/constants/enums.dart';
import 'package:wolt/models/section_model.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';

class VenueList extends StatelessWidget {
  const VenueList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<BaseViewmodel>();
    List<SectionModel>? sections = viewModel.sections;
    ApiState apiState = context.read<BaseViewmodel>().state;

    if (sections == null || sections.isEmpty || sections[1].items.isEmpty) {
      //before the first API call, values are null
      if (apiState == ApiState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }
    return Stack(
      //to show the loading state on top of the list
      children: [
        ListView.separated(
          itemBuilder: (_, index) {
            bool isFavorite =
                viewModel.isFavorite(sections![1].items[index].venue.id);
            return ItemComponent(
              imageURL: sections[1].items[index].image.imageURL,
              venueName: sections[1].items[index].venue.name,
              shortDescription: sections[1].items[index].venue.shortDescription,
              venueId: sections[1].items[index].venue.id,
              isFavorite: isFavorite,
            );
          },
          itemCount:
              sections![1].items.length > 15 ? 15 : sections[1].items.length,
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(right: 16, left: width * 0.25),
            child: const Divider(),
          ),
        ),
        Center(
          child: Builder(
            builder: (context) {
              switch (apiState) {
                case ApiState.initial:
                  return const CircularProgressIndicator();
                case ApiState.loading:
                  return const CircularProgressIndicator();
                case ApiState.success:
                  return const SizedBox.shrink();
                //todo: complete all api states
                // case ApiState.failure:
                //   return InkWell(
                //     onTap: () {
                //       // viewModel.stopLooping();
                //       // viewModel.startCoordinateLooping();
                //     },
                //     child: const Icon(Icons.replay_outlined,
                //         color: Colors.yellow, size: 50),
                //   );

                // case ApiState.idle:
                //   return InkWell(
                //     onTap: () {
                //       viewModel.stopLooping();
                //       viewModel.startCoordinateLooping();
                //     },
                //     child: const Icon(Icons.replay_outlined,
                //         color: Colors.yellow, size: 50),
                //   );
                default:
                  return const SizedBox.shrink(); // No overlay
              }
            },
          ),
        ),
      ],
    );
  }
}
