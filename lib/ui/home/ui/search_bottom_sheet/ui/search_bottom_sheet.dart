import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/search_bottom_sheet_cubit.dart';
import 'search_bottom_results_view.dart';
import 'search_bottom_sheet_not_found.dart';

class SearchBottomSheet extends StatelessWidget {
  final String search;
  const SearchBottomSheet({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      expand: false,
      builder: (context, scroll) =>
          BlocBuilder<SearchBottomSheetCubit, SearchBottomSheetState>(
        builder: (context, state) {
          if (state.isLoaded) {
            return ResultView(search: search, controller: scroll);
          }
          if (state.isError) {
            return const SearchBottomSheetNotFound(
              message: 'Error occured Check your internet connection.',
            );
          }
          return SearchBottomSheetNotFound(
            header: Icon(
              Icons.error,
              color: Colors.amber,
              size: 100,
            ),
            message: 'No MenuItem was Found',
          );
        },
      ),
    );
  }
}
