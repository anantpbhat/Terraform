/* Alta3 Research - rzfeeser@alta3.com
   Working with "for_each" within a null_resource */


/* a list of local variables */
locals {
  avengers = {
               "Iron Man"= {
                "power"= "money"
                "enemy"= "Iron Monger"}
               "Black Panther"= {
                "power"= "vibranium suit"
                "enemy"= "War Monger"}
               "She-Hulk"= {
                "power"= "super strength"
                "enemy"= "Abomination"}
             }
}


/* The null_resource implements the standard resource lifecycle but takes no more action */
resource "null_resource" "avengers" {
  for_each = tomap(local.avengers)
  /* triggers allows specifying a random set of values that when
     changed will cause the resource to be replaced */
  triggers = {
    title("enemy") = title(each.value.enemy)  // a special variable "each.value" used to specifically extract value of key "enemy"
    title("name") = title(each.key)  // a special variable, "each.key" to get the Name which is the key
    title("power") = each.value.power  // a special variable "each.value" used to specifically extract value of key "power"
  }
}

/* We want these outputs */
output "avengers" {
  value = null_resource.avengers
}
