import 'package:flutter/material.dart';
import 'package:thisconnect/utils/appTheme.dart';

Widget chatTypeMessageWidget(TextEditingController messageTextController,
    Function submitMessageFunction, bool isMessageEmpty) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: 60,
      maxHeight: 120.0,
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60,
                  maxHeight: 120.0,
                ),
                child: TextField(
                  controller: messageTextController,
                  scrollPhysics: BouncingScrollPhysics(),
                  maxLines: null,
                  style: TextStyle(color: AppTheme.gradientColorFrom),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    filled: false,
                    focusedBorder: InputBorder.none,
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: AppTheme.gradientColorTo.withOpacity(.4),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                  ),
                ),
              ),
            ),
          ),
          if (isMessageEmpty) ...[
            GestureDetector(
              onTap: () => null,
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.attach_file_outlined,
                  color: AppTheme.gradientColorFrom,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.mic,
                  color: AppTheme.gradientColorFrom,
                ),
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: () => submitMessageFunction(),
              child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.send,
                  color: AppTheme.gradientColorFrom,
                ),
              ),
            ),
          ]
        ],
      ),
    ),
  );
}
