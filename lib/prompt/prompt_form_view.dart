import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:top_dash/prompt/prompt_page.dart';
import 'package:top_dash_ui/top_dash_ui.dart';

class PromptFormView extends StatefulWidget {
  const PromptFormView({
    required this.title,
    required this.subtitle,
    required this.hint,
    required this.buttonIcon,
    super.key,
  });

  final String title;
  final String subtitle;
  final String hint;
  final IconData buttonIcon;

  @override
  State<PromptFormView> createState() => _PromptFormViewState();
}

class _PromptFormViewState extends State<PromptFormView> {
  final _text = '';

  static const _gap = SizedBox(height: TopDashSpacing.spaceUnit);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TopDashTextStyles.headlineH4Light,
        ),
        _gap,
        Text(widget.subtitle, style: TopDashTextStyles.bodyLG),
        _gap,
        Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
          child: TextFormField(
            style: TopDashTextStyles.headlineMobileH1,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TopDashTextStyles.headlineMobileH1
                  .copyWith(color: TopDashColors.seedGrey70),
            ),
          ),
        ),
        _gap,
        RoundedButton.icon(
          Icon(widget.buttonIcon),
          onPressed: () {
            // TODO(hugo): check in whitelist if entry is valid
            context
                .flow<FlowData>()
                .update((data) => data.copyWithNewAttribute(_text));
          },
        ),
      ],
    );
  }
}