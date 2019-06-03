resource "aws_route53_zone" "main" {
  name = "${var.zone_name}"
}

resource "aws_route53_record" "cname" {
    zone_id = "${aws_route53_zone.main.zone_id}"
    name = "${var.public_dns_name}"
    type = "CNAME"
    ttl = "60"
    records = ["${var.alb_dns_name}"]
}

resource "aws_route53_record" "apex" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.zone_name}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = true
  }
}