# SNS Topic for alerts
resource "aws_sns_topic" "ec2_alerts" {
  name = "ec2-alerts"
}

# SNS Topic Subscription for SMS
resource "aws_sns_topic_subscription" "sms_alerts" {
  topic_arn = aws_sns_topic.ec2_alerts.arn
  protocol  = "sms"
  endpoint  = "+84981655601"
}

# CloudWatch alarm for instance shutdown
resource "aws_cloudwatch_metric_alarm" "instance_shutdown" {
  alarm_name          = "ec2-instance-shutdown"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "EC2 instance has shut down for 1 minute"
  alarm_actions       = [aws_sns_topic.ec2_alerts.arn]
  treat_missing_data  = "breaching"

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}