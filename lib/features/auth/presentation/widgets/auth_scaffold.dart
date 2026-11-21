import 'package:material_ui/material_ui.dart';

import '../../../../core/layout/app_screen.dart';
import '../../../../core/layout/app_window.dart';
import '../../../../core/layout/content_frame.dart';
import '../../../../core/layout/two_pane.dart';
import '../../../../core/theme/app_tokens.dart' hide formatNaira;
import '../../../../core/widgets/app_assets.dart';
import '../../../../core/widgets/app_icon.dart';
import '../../../../l10n/app_localizations.dart';
import 'brand_panel.dart';

/// The frame every sign-on screen shares (Figma: status bar, 52px top row,
/// body, bottom actions).
///
/// - Compact: body scrolls, [actions] sit pinned to the bottom.
/// - Medium (tablet portrait): one centred column, actions follow the form.
/// - Expanded and folds (a hinge): the logo card on one side, the column on the
///   other. The seam at a hinge stays empty.
class const AuthScaffold({
  required final Widget body,
  final Widget? actions,

  /// Null means no back button (Welcome, "You're in").
  final VoidCallback? onBack,

  /// Centre a short body vertically (Welcome).
  final bool centerBody = false,
  super.key,
}) extends StatefulWidget {
  static const columnWidth = 440.0;

  /// True when the logo card shows beside the form. Welcome uses it to leave
  /// the logo out of the form column.
  static bool showsPanel(BuildContext context) {
    final window = AppWindow.of(context);
    return window.canShowTwoPanes &&
        (window.hinge != null || window.isExpanded);
  }

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState() extends State<AuthScaffold> {
  // The form moves between a one-column and a two-pane layout when the window
  // changes (fold, unfold, resize). Without these keys the fields would be
  // rebuilt under a new parent and lose focus, closing the keyboard mid-typing.
  // A GlobalKey carries the same State (focus, cursor, composing text) across.
  final _bodyKey = GlobalKey(debugLabel: 'authBody');
  final _actionsKey = GlobalKey(debugLabel: 'authActions');

  @override
  Widget build(BuildContext context) {
    final window = AppWindow.of(context);
    final body = KeyedSubtree(key: _bodyKey, child: widget.body);
    final actions = widget.actions == null
        ? null
        : KeyedSubtree(key: _actionsKey, child: widget.actions!);
    final Widget content;
    if (AuthScaffold.showsPanel(context)) {
      content = TwoPane(
        primary: const BrandPanel(),
        primaryWidth: window.size.width * 0.48,
        secondary: _WideColumn(
          body: body,
          actions: actions,
          onBack: widget.onBack,
        ),
      );
    } else if (window.isCompact) {
      content = _CompactColumn(
        body: body,
        actions: actions,
        onBack: widget.onBack,
        centerBody: widget.centerBody,
      );
    } else {
      content = _WideColumn(
        body: body,
        actions: actions,
        onBack: widget.onBack,
      );
    }
    return AppScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: content),
      ),
    );
  }
}

class const _BackRow({final VoidCallback? onBack}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.tokens;
    return SizedBox(
      height: 52,
      child: Align(
        alignment: Alignment.centerLeft,
        child: onBack == null
            ? const SizedBox(width: 44)
            : IconButton(
                onPressed: onBack,
                tooltip: AppLocalizations.of(context).backLabel,
                icon: AppIcon(AppAssets.chevronLeft, color: c.ink),
              ),
      ),
    );
  }
}

class const _CompactColumn({
  required final Widget body,
  required final Widget? actions,
  required final VoidCallback? onBack,
  required final bool centerBody,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s3),
        child: _BackRow(onBack: onBack),
      ),
      Expanded(
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight),
              child: ContentFrame(
                maxWidth: AuthScaffold.columnWidth,
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.s5),
                child: centerBody ? Center(child: body) : body,
              ),
            ),
          ),
        ),
      ),
      if (actions != null)
        ContentFrame(
          maxWidth: AuthScaffold.columnWidth,
          padding: const EdgeInsets.fromLTRB(
            AppSpace.s5,
            AppSpace.s2,
            AppSpace.s5,
            AppSpace.s3,
          ),
          // ContentFrame hands its child loose constraints, so a lone button
          // would shrink to its label. Actions are always full width.
          child: SizedBox(width: double.infinity, child: actions),
        ),
    ],
  );
}

class const _WideColumn({
  required final Widget body,
  required final Widget? actions,
  required final VoidCallback? onBack,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: ContentFrame(
        maxWidth: AuthScaffold.columnWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.s5,
          vertical: AppSpace.s6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (onBack != null)
              Align(
                alignment: Alignment.centerLeft,
                child: _BackRow(onBack: onBack),
              ),
            body,
            if (actions != null) ...[
              const SizedBox(height: AppSpace.s6),
              actions!,
            ],
          ],
        ),
      ),
    ),
  );
}
