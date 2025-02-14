import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: TextField(
        onChanged: (value) {
          context.read<FinanceProvider>().setSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: 'Ara...',
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface.withOpacity(0.8),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle:
              TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5)),
        ),
        style: TextStyle(color: theme.colorScheme.onSurface),
      ),
    );
  }
}
