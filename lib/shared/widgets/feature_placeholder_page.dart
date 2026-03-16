import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class FeaturePlaceholderPage extends ConsumerWidget {
  const FeaturePlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.highlights,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final List<String> highlights;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveSectionScaffold(
      title: title,
      body: CustomScrollView(
        physics: Theme.of(context).platform == TargetPlatform.iOS
            ? const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              )
            : const ClampingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverList.builder(
              itemCount: highlights.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VynixGlassCard(
                      child: Row(
                        children: [
                          Icon(icon, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              subtitle,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final item = highlights[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VynixGlassCard(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
