resource "aws_lb" "kpmg-web-alb" {
  name               = "kpmg-demo-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kpmg-sg-pub.id]
  subnets            = [aws_subnet.kpmg-subnet-pub-az1.id, aws_subnet.kpmg-subnet-pub-az2.id, aws_subnet.kpmg-subnet-pub-az3.id]

  enable_deletion_protection = true

  #access_logs {
  #  bucket  = aws_s3_bucket.lb_logs.bucket
  #  prefix  = "test-lb"
  #  enabled = true
  #}

  tags = {
    Environment = "demo"
  }
}

################################################
# Target Group for Application Load Balancer
################################################
resource "aws_lb_target_group" "kpmg-web-tg" {
  name     = "kpmg-demo-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.kpmg-vpc.id}"
}
resource "aws_lb_target_group_attachment" "kpmg-web-tg-attachment" {
  target_group_arn = "${aws_lb_target_group.kpmg-web-tg.arn}"
  target_id        = "${aws_instance.kpmg-ec2.id}"
  port             = 80
}
resource "aws_lb_listener" "kpmg-web-alb-listener" {
  load_balancer_arn = "${aws_lb.kpmg-web-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.kpmg-web-tg.arn}"
  }
}