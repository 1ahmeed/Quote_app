// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quotes/core/utils/media_query_values.dart';
// import 'package:quotes/features/random_quote/presentation/cubit/quote_cubit.dart';
//
// import '../../config/locale/app_localizations.dart';
// import '../utils/app_color.dart';
//
// class ErrorScreen extends  StatelessWidget {
//   final VoidCallback? onPress;
//   const ErrorScreen({Key? key, this.onPress}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuoteCubit, QuoteState>(
//   builder: (context, state) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Icon(
//               Icons.warning_amber_rounded,
//               color: AppColors.primary,
//               size: 150,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 12),
//             child: Text(
//               AppLocalizations.of(context)!.translate('something_went_wrong')!,
//               style: const TextStyle(
//                   color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//           ),
//           Text(
//              AppLocalizations.of(context)!.translate('try_again')!,
//             style: TextStyle(
//                 color: AppColors.hint, fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           Container(
//             height: 55,
//             width: context.width * 0.55,
//             margin: const EdgeInsets.symmetric(vertical: 15),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Theme.of(context).primaryColor,
//                   elevation: 500,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50))),
//               child: Text(
//                 AppLocalizations.of(context)!.translate('reload_screen')!,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700),
//               ),
//               onPressed: () {
//                 QuoteCubit.get(context)?.getRandomQuote();
//                 if (onPress != null) {
//                   onPress!();
//                 }
//               },
//             ),
//           )
//         ],
//       )
//     );
//   },
// );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/media_query_values.dart';

import '../utils/app_color.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onPress;
  const ErrorScreen({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            AppLocalizations.of(context)!.translate('something_went_wrong')!,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.translate('try_again')!,
          style: TextStyle(
              color: AppColors.hint, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Container(
          height: 55,
          width: context.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Theme.of(context).primaryColor,
                elevation: 500,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              AppLocalizations.of(context)!.translate('reload_screen')!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}
