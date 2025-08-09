# SNS Topic for alerts
resource "aws_sns_topic" "ec2_alerts" {
  name = "ec2-alerts"
}

# SNS Topic Subscription (replace with your email)
resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.ec2_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Update the alarm to use the created topic
resource "aws_cloudwatch_metric_alarm" "instance_shutdown" {
  alarm_name          = "ec2-instance-shutdown"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "EC2 instance has shut down"
  alarm_actions       = [aws_sns_topic.ec2_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}