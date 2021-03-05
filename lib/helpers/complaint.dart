class Complaint {
  final String id;
  final String comp_user_id;
  final String address;
  final String contact;
  final String date;
  final String desc;
  final String area_of_comp;
  final Map location;
  final String name;
  final String user_email;

  Complaint({
    this.id,
    this.address,
    this.contact,
    this.date,
    this.desc,
    this.location,
    this.name,
    this.area_of_comp,
    this.user_email,
    this.comp_user_id,
  });
}
