import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2gsoft_ecommerce/model/product_list_model.dart';
import '../blocs/product_cubit.dart';
import '../variables/variables.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key,required this.index, required this.item}) : super(key: key);
  final int index;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular( wd*.05)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Container(color: Colors.green),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: wd*.67,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular( wd*.05)),
                color: Colors.white
              ),
              padding: EdgeInsets.symmetric(horizontal: wd*.02),
              child: Column(
                children: [
                  SizedBox(height:wd*.04),
                  CachedNetworkImage(
                    imageUrl: '${Variables.domain}${item.thumbnail}',
                    placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey,size: wd*.3),
                    errorWidget: (context, url, error) => Icon(Icons.error,size: wd*.25,color: Colors.grey),
                    height: wd*.3,
                    fit: BoxFit.cover),
                  //Image.asset('assets/p1.png',height: wd*.3),
                  SizedBox(height:wd*.03),
                  Text(item.name??'',maxLines: 2,style: TextStyle(fontSize: wd*.042,height: 1.2)),
                  SizedBox(height:wd*.02),

                  Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(fontSize: wd*.048, color: Variables.primaryColor,fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                //TextSpan(text: 'price', style: TextStyle(fontSize: wd*.03, color: Colors.grey)),
                                TextSpan(text: ' ৳${item.price}'),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),
          ),

          ///Card Section
          pc.addedToCart==true && pc.tempIndex==index
              ? Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(wd*.01),
                margin: EdgeInsets.symmetric(horizontal: wd*.04),
                decoration: BoxDecoration(
                  color: Variables.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular( wd*.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        pc.decrementCart(index);
                      },
                      child: Container(
                        height: wd*.1,
                        width: wd*.1,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color:Color(0xffFFBFDD)
                        ),
                        child: Icon(Icons.remove,color: Colors.white,size: wd*.065),
                      ),
                    ),

                    Text('${pc.cartCount}',style: TextStyle(color: Variables.primaryColor,fontWeight: FontWeight.bold,fontSize: wd*.04),),

                    InkWell(
                      onTap: (){
                        pc.incrementCart(index);
                      },
                      child: Container(
                        height: wd*.1,
                        width: wd*.1,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [
                                  Variables.purpleLite,
                                  Variables.purpleDeep],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            )
                        ),
                        child: Icon(Icons.add,color: Colors.white,size: wd*.065),
                      ),
                    )
                  ],
                ),
              )
          )
              : Positioned(
            bottom: 0.0,
            child: InkWell(
              onTap: (){
                pc.changeCart(true,index);
              },
              child: Container(
                height: wd*.12,
                width: wd*.12,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Variables.purpleLite,
                          Variables.purpleDeep],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                child: Icon(Icons.add,color: Colors.white,size: wd*.065),
              ),
            ),
          ),

          ///Stock Out
          if(item.currentStock==null || item.currentStock!.toString().isEmpty)
          Positioned(
            top: wd*.02,
            right: wd*.02,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: wd*.02,vertical: 1),
              decoration: const BoxDecoration(
                color: Variables.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Text('Stock out',style: TextStyle(fontSize: wd*.04,color: Variables.primaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
