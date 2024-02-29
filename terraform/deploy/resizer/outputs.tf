output "dog_url" {
  value = "https://${module.resizer.host_name}/${module.resizer.destination_directory}/dog/portrait.jpeg"
}

output "possum_url" {
  value = "https://${module.resizer.host_name}/${module.resizer.destination_directory}/possum/large.webp"
}
