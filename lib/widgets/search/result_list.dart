import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:sul_sul/models/preference_model.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/search/result_card.dart';

class ResultList extends StatefulWidget {
  final List<PreferenceResponse> results;
  final String target;
  final void Function() onTap;

  const ResultList({
    super.key,
    required this.results,
    required this.target,
    required this.onTap,
  });

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  bool isExpanded = false;

  void _onPressedMoreButton() {
    setState(() {
      isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EasyRichText(
            '${widget.target} ${widget.results.length}',
            defaultStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            patternList: [
              EasyRichTextPattern(
                targetString: '${widget.results.length}',
                style: const TextStyle(
                  color: Main.main,
                ),
              ),
            ],
          ),
          for (var result in (isExpanded
              ? widget.results
              : widget.results.sublist(
                  0, widget.results.length > 3 ? 3 : widget.results.length)))
            ResultCard(
              result: result,
              subtype: widget.target == Pairings.food ? result.subtype : null,
              onTap: widget.onTap,
            ),
          if (widget.results.length > 3 && isExpanded == false)
            Button(
              title: '검색결과 ${widget.results.length - 3}개 더보기',
              onPressed: _onPressedMoreButton,
              type: ButtonType.plane,
              size: ButtonSize.large,
            ),
        ],
      ),
    );
  }
}
