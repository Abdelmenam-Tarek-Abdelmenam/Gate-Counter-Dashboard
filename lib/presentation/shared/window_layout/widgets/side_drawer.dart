import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gate_counter/bloc/layout_bloc/layout_bloc.dart';
import 'package:gate_counter/presentation/resources/styles_manager.dart';
import 'package:gate_counter/presentation/shared/widget/dividers.dart';

import '../../../resources/asstes_manager.dart';
import '../../../resources/string_manager.dart';
import 'info_dialog.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingManager.p10,
      child: Column(
        children: [
          header(context),
          Dividers.h10,
          Expanded(child: BlocBuilder<LayoutBloc, ActiveLayout>(
            builder: (context, state) {
              return Column(
                children: ActiveLayout.values
                    .map((e) => tileDesign(context, e, state))
                    .toList(),
              );
            },
          )),
          trailer(context)
        ],
      ),
    );
  }

  Widget tileDesign(BuildContext context, ActiveLayout e, ActiveLayout state) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          onPressed: () =>
              context.read<LayoutBloc>().add(ChangeActiveLayout(e)),
          height: 50,
          elevation: 0,
          color: state == e
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Dividers.w10,
              Icon(
                e.getIcon,
                size: 25,
                color: state == e
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              Dividers.w10,
              Text(
                e.getString,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: state == e
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      );

  Widget header(BuildContext context) => Row(
        children: [
          Image.asset(
            AssetsManager.logo,
            width: 50,
            fit: BoxFit.contain,
          ),
          Dividers.w10,
          Text(
            StringManger.appName,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 18),
          ),
        ],
      );

  Widget trailer(BuildContext context) => InkWell(
        onTap: () {
          // show dialog
          showDialog(
              context: context,
              builder: (_) {
                return const Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: StyleManager.border,
                  ),
                  child: InfoDialog(),
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 25,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            Dividers.w5,
            Text(
              StringManger.about,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16),
            ),
          ],
        ),
      );
}
