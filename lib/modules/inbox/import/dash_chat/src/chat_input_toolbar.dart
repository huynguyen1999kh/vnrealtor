part of dash_chat;

class ChatInputToolbar extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle inputTextStyle;
  final InputDecoration inputDecoration;
  final TextCapitalization textCapitalization;
  final BoxDecoration inputContainerStyle;
  final List<Widget> leading;
  final List<Widget> trailling;
  final int inputMaxLines;
  final int maxInputLength;
  final bool alwaysShowSend;
  final ChatUser user;
  final Function(ChatMessage) onSend;
  final String text;
  final Function(String) onTextChange;
  final bool inputDisabled;
  final String Function() messageIdGenerator;
  final Widget Function(Function) sendButtonBuilder;
  final Widget Function() inputFooterBuilder;
  final bool showInputCursor;
  final double inputCursorWidth;
  final Color inputCursorColor;
  final ScrollController scrollController;
  final bool showTraillingBeforeSend;
  final FocusNode focusNode;
  final EdgeInsets inputToolbarPadding;
  final EdgeInsets inputToolbarMargin;
  final TextDirection textDirection;
  final bool sendOnEnter;
  final bool reverse;
  final TextInputAction textInputAction;
  final Color iconSendColor;

  ChatInputToolbar({
    Key key,
    this.textDirection = TextDirection.ltr,
    this.focusNode,
    this.scrollController,
    this.text,
    this.textInputAction,
    this.sendOnEnter = false,
    this.onTextChange,
    this.inputDisabled = false,
    this.controller,
    this.iconSendColor,
    this.leading = const [],
    this.trailling = const [],
    this.inputDecoration,
    this.textCapitalization,
    this.inputTextStyle,
    this.inputContainerStyle,
    this.inputMaxLines = 1,
    this.showInputCursor = true,
    this.maxInputLength,
    this.inputCursorWidth = 2.0,
    this.inputCursorColor,
    this.onSend,
    this.reverse = false,
    @required this.user,
    this.alwaysShowSend = false,
    this.messageIdGenerator,
    this.inputFooterBuilder,
    this.sendButtonBuilder,
    this.showTraillingBeforeSend = true,
    this.inputToolbarPadding = const EdgeInsets.all(0.0),
    this.inputToolbarMargin = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatMessage message = ChatMessage(
      text: controller.text,
      user: user,
      messageIdGenerator: messageIdGenerator,
      createdAt: DateTime.now(),
    );

    return Container(
      padding: inputToolbarPadding,
      margin: inputToolbarMargin,
      decoration: inputContainerStyle != null
          ? inputContainerStyle
          : BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Directionality(
                    textDirection: textDirection,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextField(
                        focusNode: focusNode,
                        onChanged: (value) {
                          onTextChange(value);
                        },
                        onSubmitted: (value) {
                          if (sendOnEnter) {
                            _sendMessage(context, message);
                          }
                        },
                        textInputAction: textInputAction,
                        buildCounter: (
                          BuildContext context, {
                          int currentLength,
                          int maxLength,
                          bool isFocused,
                        }) =>
                            null,
                        decoration: inputDecoration != null
                            ? inputDecoration
                            : InputDecoration.collapsed(
                                hintText: "",
                                fillColor: Colors.white,
                              ),
                        textCapitalization: textCapitalization,
                        controller: controller,
                        style: inputTextStyle,
                        maxLength: maxInputLength,
                        minLines: 1,
                        maxLines: inputMaxLines,
                        showCursor: showInputCursor,
                        cursorColor: inputCursorColor,
                        cursorWidth: inputCursorWidth,
                        enabled: !inputDisabled,
                      ),
                    ),
                  ),
                ),
              ),
              if (showTraillingBeforeSend) ...trailling,
              if (sendButtonBuilder != null)
                sendButtonBuilder(() {
                  // if (text.length != 0) {
                  onSend(message);

                  controller.text = "";

                  onTextChange("");
                  // }
                })
              else
                alwaysShowSend || controller.text.trim() != ''
                    ? IconButton(
                        icon: Icon(
                          Icons.send,
                          color: iconSendColor,
                        ),
                        onPressed:
                            alwaysShowSend || controller.text.trim() != ''
                                ? () => _sendMessage(context, message)
                                : null,
                      )
                    : SizedBox.shrink(),
              if (!showTraillingBeforeSend) ...trailling,
            ],
          ),
          if (inputFooterBuilder != null) inputFooterBuilder()
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, ChatMessage message) {
    // if (text.length != 0) {
    onSend(message);

    controller.text = "";

    onTextChange("");

    FocusScope.of(context).requestFocus(focusNode);

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(
        reverse ? 0.0 : scrollController.position.maxScrollExtent + 100.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    });
    // }
  }
}
