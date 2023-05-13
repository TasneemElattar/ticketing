

class TicketCategory {
  TicketCategory({
    required this.id,
    required this.categoryName,
    required this.ticket_subcategories
    ,required this.ticket_projects

  });

  String id;
  String categoryName;
  List<TicketSubCategory> ticket_subcategories;
  List<TicketProjects> ticket_projects;

}

class TicketSubCategory {
  TicketSubCategory({
    required this.id,
    required this.categoryName,
  });

  String id;
  String categoryName;


}


class TicketProjects {
  TicketProjects({
    required this.id,
    required this.name,
  });

  String id;
  String name;


}