import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wolt/constants/constants.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';

class ItemComponent extends StatelessWidget {
  final String? imageURL;
  final String? venueName;
  final String? shortDescription;
  final String? venueId;
  final bool isFavorite;
  const ItemComponent(
      {super.key,
      this.imageURL,
      this.venueName,
      this.shortDescription,
      this.venueId,
      this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        venueName ?? "no name",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        shortDescription ?? "no description",
        overflow: TextOverflow.ellipsis,
        maxLines: 1, //can change according to business values
      ),
      leading: ClipRRect(
        //can be squared too
        borderRadius: BorderRadius.circular(16),
        child: imageURL != null
            ? Image.network(
                imageURL!,
                fit: BoxFit.cover,
              )
            : const Placeholder(),
      ),
      trailing: //
          InkWell(
        onTap: () {
          context.read<BaseViewmodel>().toggleFavorite(venueId!);
          print("VanueID of: $venueId : $isFavorite");
          List<String> faves = context.read<BaseViewmodel>().getFavorites();
          print("local faves: $faves");
          context.read<BaseViewmodel>().initializeFavorites();
          print("is in local faves: ${faves.contains(venueId)}");
          List<String> faves2 = context.read<BaseViewmodel>().getFavorites();
          print("storage faves: $faves2");
          print("is in storage faves: ${faves2.contains(venueId)}");
        },
        child: SvgPicture.asset(
          isFavorite ? Constants.favoriteTrue : Constants.favoriteFalse,
          height: 32,
        ),
      ),
    );
  }
}
