import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grilled_steak_app/ui/home/view/search_bottom_sheet/cubit/search_bottom_sheet_cubit.dart';
import 'package:grilled_steak_app/ui/home/view/search_bottom_sheet/ui/search_bottom_sheet.dart';

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
      // height: 80,
      child: TextField(
        enabled: true,
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
          fillColor: Colors.white,
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
      ),
    );
  }
}
