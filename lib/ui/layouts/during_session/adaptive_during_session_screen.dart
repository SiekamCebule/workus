import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/constants/layouting.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/selected_page.dart';
import 'package:workus/ui/layouts/before_session/widgets/large_play_pause_button.dart';
import 'package:workus/ui/layouts/during_session/widgets/during_session_screen_app_bar.dart';
import 'package:workus/ui/layouts/during_session/widgets/large_remaining_time_label.dart';
import 'package:workus/ui/layouts/during_session/widgets/next_small_break_info/next_small_break_info_content.dart';
import 'package:workus/ui/layouts/during_session/widgets/remaining_time_texts_column.dart';
import 'package:workus/ui/layouts/during_session/widgets/shaked_current_quote.dart';
import 'package:workus/ui/layouts/dynamic_work_screen/play_pause_button/play_pause_button.dart';
import 'package:workus/ui/reusable/slideout_for_page.dart';

part '__horizontal_phone.dart';
part '__except_horizontal_phone.dart';

class AdaptiveDuringSessionScreen extends ConsumerWidget {
  const AdaptiveDuringSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutType = LayoutType.fromConstraints(constraints);
        return switch (layoutType) {
          LayoutType.horizontalPhone => const _HorizontalPhone(),
          _ => const _ExceptHorizontalPhone(),
        };
      },
    );
  }
}
