# produces an output value named "space_heroes"
output "Response_Title" {
  description = "API that documents folks in space"
  value       = jsondecode(data.http.iss.response_body).title
}




