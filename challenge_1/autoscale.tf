
resource"aws_launch_configuration" "launch-config" {
  name = var.env
  image_id = data.aws_ami.latest-ubuntu.id
  instance_type = var.ec2_instance_type
  security_groups = [aws_security_group.kpmg-sg-pvt.id]
}

resource "aws_autoscaling_group" "worker" {
    name = "${aws_launch_configuration.launch-config.name}-asg"
    min_size             = 2
    desired_capacity     = 2
    max_size             = 4
    health_check_type    = "EC2"

    launch_configuration = "${aws_launch_configuration.launch-config.name}"
    vpc_zone_identifier  = [aws_subnet.kpmg-subnet-pvt-az1.id, aws_subnet.kpmg-subnet-pvt-az2.id, aws_subnet.kpmg-subnet-pvt-az3.id]
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.worker.id
  alb_target_group_arn   = aws_lb_target_group.kpmg-tg.arn
}

resource "aws_lb" "kpmg-alb" {
  name               = "kpmg-dev-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kpmg-sg-pvt.id]
  subnets            = [aws_subnet.kpmg-subnet-pvt-az1.id, aws_subnet.kpmg-subnet-pvt-az2.id, aws_subnet.kpmg-subnet-pvt-az3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "demo"
  }
}

################################################
# Target Group for Application Load Balancer
################################################
resource "aws_lb_target_group" "kpmg-tg" {
  name     = "kpmg-dev-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.kpmg-vpc.id}"
}

resource "aws_lb_listener" "kpmg-alb-listener" {
  load_balancer_arn = "${aws_lb.kpmg-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.kpmg-tg.arn}"
  }
}