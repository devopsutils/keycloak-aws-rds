output "alb_public_dns" {
    value = "${module.alb.alb_dns_name}"
}

output "public_dns_name" {
    value = "${var.public_dns_name}"
}