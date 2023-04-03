import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_dash/l10n/l10n.dart';
import 'package:top_dash/prompt/bloc/prompt_form_bloc.dart';
import 'package:top_dash/prompt/view/prompt_form_view.dart';

class FlowData extends Equatable {
  const FlowData({this.character, this.power, this.environment});

  final String? character;
  final String? power;
  final String? environment;

  FlowData copyWithNewAttribute(String attribute) {
    return FlowData(
      character: character ?? attribute,
      power: character != null ? power ?? attribute : null,
      environment: power != null ? environment ?? attribute : null,
    );
  }

  @override
  List<Object?> get props => [character, power, environment];
}

class PromptForm extends StatelessWidget {
  const PromptForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PromptFormBloc>();
    return Scaffold(
      body: FlowBuilder<FlowData>(
        state: const FlowData(),
        onComplete: (data) {
          bloc.add(PromptSubmitted(data: data));
        },
        onGeneratePages: (data, pages) {
          return [
            MaterialPage(
              child: PromptFormView(
                title: context.l10n.characterPromptPageTitle,
                subtitle: context.l10n.characterPromptPageSubtitle,
                hint: context.l10n.characterPromptPageHint,
                buttonIcon: Icons.arrow_forward,
              ),
            ),
            if (data.character != null)
              MaterialPage(
                child: PromptFormView(
                  title: context.l10n.powerPromptPageTitle,
                  subtitle: context.l10n.powerPromptPageSubtitle,
                  hint: context.l10n.powerPromptPageHint,
                  buttonIcon: Icons.arrow_forward,
                ),
              ),
            if (data.power != null)
              MaterialPage(
                child: PromptFormView(
                  title: context.l10n.environmentPromptPageTitle,
                  subtitle: context.l10n.environmentPromptPageSubtitle,
                  hint: context.l10n.environmentPromptHint,
                  buttonIcon: Icons.check,
                  isLastOfFlow: true,
                ),
              ),
          ];
        },
      ),
    );
  }
}