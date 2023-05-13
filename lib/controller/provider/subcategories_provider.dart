// import 'package:flutter/material.dart';
// import 'package:ticketing_system/model/ticket_category.dart';
//
//
// class SubCategoriesProvider extends ChangeNotifier{
//   TicketSubCategory? selectedSubCategory;
//   List<TicketSubCategory> SubCategories=[];
//   int sub_category_length=0;
//   setSelectedSubCategory(TicketSubCategory selected){
//     selectedSubCategory=selected;
//     notifyListeners();
//   }
//   setSubCategories( List<TicketSubCategory> subcategories,int length_sub){
//     SubCategories=subcategories;
//     sub_category_length=length_sub;
//     selectedSubCategory=SubCategories.length==0?null:SubCategories[0];
//     notifyListeners();
//   }
//
// }