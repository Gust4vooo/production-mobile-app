# TODO: Move Search Bar to Core Widgets

## Completed Tasks
- [x] Create lib/core/widgets/search_bar.dart: A reusable CustomSearchBar widget that takes hintText, onChanged callback, etc.
- [x] Update stock_page.dart: Replace the inline TextField with the new CustomSearchBar widget, import it, and connect to viewModel for filtering if needed.
- [x] Update production_page.dart: Add the CustomSearchBar widget at the top, import it, and connect to viewModel for filtering production items.

## Followup Steps
- [ ] Test the search functionality on both pages.
- [ ] Ensure no breaking changes.
- [ ] Implement actual search logic in the viewModels if needed.
