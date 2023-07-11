data "aws_route53_zone" "holasoyfranco" {
  name = "holasoyfranco.com"
  # private_zone = true
}

resource "aws_route53_record" "rockolify" {
  zone_id = data.aws_route53_zone.holasoyfranco.zone_id
  name    = "rockolify.${data.aws_route53_zone.holasoyfranco.name}"
  type    = "A"

  alias {
    name                   = aws_lb.rockolify_lb.dns_name
    zone_id                = aws_lb.rockolify_lb.zone_id
    evaluate_target_health = true
  }
}


resource "aws_acm_certificate" "cert" {
  domain_name       = "rockolify.holasoyfranco.com"
  validation_method = "DNS"
}


resource "aws_route53_record" "cert_validation" {
  depends_on      = [aws_acm_certificate.cert]
  zone_id         = data.aws_route53_zone.holasoyfranco.id
  name            = sort(aws_acm_certificate.cert.domain_validation_options[*].resource_record_name)[0]
  type            = "CNAME"
  ttl             = "300"
  records         = [sort(aws_acm_certificate.cert.domain_validation_options[*].resource_record_value)[0]]
  allow_overwrite = true
}
