// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SelectedAutopayGrid extends StatelessWidget {
  final List<Beneficiary> beneficiary;
  final void Function() onAdd;
  final void Function(int) onDelete;

  const SelectedAutopayGrid({
    super.key,
    required this.beneficiary,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 0.68,
      ),
      children: [
        ...beneficiary.mapIndexed((idx, bf) => autopayTile(bf, idx)),
        addBeneficiary(),
      ],
    );
  }

  Column addBeneficiary() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            onTap: onAdd,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: NbColors.black),
              ),
              child: Icon(
                Icons.add,
                size: 28.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget autopayTile(Beneficiary beneficiary, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            onDelete(index);
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 8.r,
                  bottom: 0,
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF897AE5)),
                    child: NbText.sp18(beneficiary.name[0]).w600.white,
                  ),
                ),
                Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: NbColors.black),
                  child: Icon(
                    Icons.close,
                    size: 15.r,
                    color: NbColors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: NbText.sp16(beneficiary.name)
              .w500
              .black
              .centerText
              .setMaxLines(1),
        ),
      ],
    );
  }
}
