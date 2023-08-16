import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

appPrimaryDialog({
  required BuildContext context,
  required String title,
  bool barrierDismissible = true,
  String? subTitle,
  String? primaryButtonText,
  String? secondaryButtonText,
  Function()? onTapPrimaryButton,
  Function()? onTapSecondaryButton,
}) async {
  await showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        content: subTitle != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(subTitle,
                    style: Theme.of(context).textTheme.bodyLarge),
              )
            : null,
        actions: primaryButtonText != null
            ? [
                if (secondaryButtonText != null)
                  TextButton(
                    onPressed: onTapSecondaryButton,
                    child: Text(
                      secondaryButtonText,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                    ),
                  ),
                TextButton(
                  onPressed: onTapPrimaryButton,
                  child: Text(
                    primaryButtonText,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.blueAccent),
                  ),
                ),
              ]
            : secondaryButtonText != null
                ? [
                    TextButton(
                      onPressed: onTapSecondaryButton,
                      child: Text(
                        secondaryButtonText,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent),
                      ),
                    ),
                  ]
                : [],
      );
    },
  );
}
