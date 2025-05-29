#brinabh.com
# Create a Route 53 hosted zone for your domain
resource "aws_route53_zone" "main" {
  name = "brinabh.com"
}

# Output the NS records that Route 53 creates automatically
output "route53_name_servers" {
  value = aws_route53_zone.main.name_servers
}

# Example: create an A record for 'www.brinabh.com' aliasing your S3 website endpoint or IP
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.brinabh.com"
  type    = "A"

  alias {
    name                   = "s3-website-us-east-1.amazonaws.com" # Change to your actual S3 website endpoint
    zone_id                = "Z3AQBSTGFYJSTF"                     # Hosted zone ID for S3 website in us-east-1 (fixed)
    evaluate_target_health = false
  }
}