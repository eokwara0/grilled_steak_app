import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../search_bottom_sheet/cubit/search_bottom_sheet_cubit.dart';
import '../../search_bottom_sheet/ui/search_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuSearch extends StatefulWidget {
  const MenuSearch({
    super.key,
  });

  @override
  State<MenuSearch> createState() => _MenuSearchState();
}

class _MenuSearchState extends State<MenuSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.searchText,
            style: TextStyle(
              color: Colors.white.withOpacity(.9),
              height: 1,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
          ),
          TextField(
            enabled: true,
            autocorrect: false,

            // cursor color
            cursorColor: Colors.amber,

            // search decoration
            decoration: InputDecoration(
              //prefix icon
              prefixIconColor: Colors.grey,
              prefixIcon: const Icon(Icons.search),

              // filled
              filled: true,

              // fill color
              fillColor: Colors.grey.shade200.withOpacity(1),
              // content padding

              contentPadding: const EdgeInsets.all(10),

              // default border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),

              // focused border
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),

            // onSubmitted
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<SearchBottomSheetCubit>().onSubmit(value);
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  context: context,
                  builder: (context) => SearchBottomSheet(search: value),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
