import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../../../../config/ps_colors.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/utils/utils.dart';

class IAPPromoteItem extends StatelessWidget {
  const IAPPromoteItem({required this.prod, required this.onPressed});
  final ProductDetails prod;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space10, 
            bottom: PsDimens.space8,
            right:PsDimens.space10 ),
        padding: const EdgeInsets.only(
            top: PsDimens.space8, 
            left: PsDimens.space8, 
            right: PsDimens.space8),
        decoration: BoxDecoration(
        color:
            Utils.isLightMode(context) ? PsColors.text50 : PsColors.achromatic600,
        borderRadius: BorderRadius.circular(PsDimens.space4),
      ),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.end,
           mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [          
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    prod.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,
                            fontSize: 16,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                       prod.price,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18,
                          ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.only(top:2,bottom: 6, ),
                     child:  Row(
                         children: <Widget>[
                          const Icon(Icons.check_circle_outlined,size: 18,),
                           Expanded(
                             child: Text(                   
                                  prod.description,  
                                  overflow: TextOverflow.ellipsis,                  
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
                                 ),
                           ),
                         ],
                       ),
                     
                   ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
