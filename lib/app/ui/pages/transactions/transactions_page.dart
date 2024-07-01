import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
import 'package:nitrobills/app/ui/pages/transactions/transactions_loading_page.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/transaction_tile.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<TransactionsController>().initialize();
    });

    return GetX<TransactionsController>(
      init: Get.find<TransactionsController>(),
      builder: (cntrl) {
        if (cntrl.status.value.isLoading) {
          return const TransactionsLoadingPage();
        } else {
          return Scaffold(
            backgroundColor: const Color(0xFFEBEBEB),
            body: SafeArea(
              bottom: false,
              child: RefreshIndicator(
                color: NbColors.black,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  await cntrl.reload();
                },
                child: Column(
                  children: [
                    18.verticalSpace,
                    NbText.sp18("Transactions").w600.black,
                    16.verticalSpace,
                    if (cntrl.transactions.isEmpty)
                      const EmptyFieldsWidget(
                        image: NbImage.noTransactions,
                        text: "You haven't made any transaction yet.",
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 100.h),
                            itemBuilder: (context, index) {
                              return TransactionTile(
                                transaction: cntrl.transactions[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                30.verticalSpace,
                            itemCount: cntrl.transactions.length),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
