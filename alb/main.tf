resource "aws_alb_target_group" "main" {
  name     = "${var.alb_target_group_name}"
  port     = "${var.alb_target_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb" "main" {
  name            = "${var.alb_name}"
  subnets = "${var.subnet_ids}"
  security_groups = "${var.security_groups}"
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "${var.alb_port}"
  protocol          = "${var.alb_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.main.id}"
    type             = "forward"
  }
}
