output "app_iam_instance_profile_name" {
    value = "${aws_iam_instance_profile.app.name}"
}

output "ecs_iam_role_name" {
    value = "${aws_iam_role.ecs_service.name}"
}

output "ecs_service_iam_role_policy" {
    value = "${aws_iam_role.ecs_service.id}"
}