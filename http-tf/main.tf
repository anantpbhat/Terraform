# The following example shows how to issue an HTTP GET request supplying
# an optional request header.
data "http" "iss" {
//  url = "http://api.open-notify.org/astros.json"      // API to send HTTP GET to
  url = "https://api.nasa.gov/planetary/apod?api_key=5gmMYv2iEvUEAARLRg1U80gyYFvZZGitdYHzUHcU"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Accept-Language: "en-US"
  }
}
