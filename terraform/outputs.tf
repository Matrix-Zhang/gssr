output "ip" {
  value = google_compute_instance.terraform_ssr_vm.network_interface[0].access_config[0].nat_ip
}
