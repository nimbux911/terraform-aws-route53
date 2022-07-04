locals {
  zone_id = concat(
    aws_route53_zone.private.*.zone_id,
    aws_route53_zone.public.*.zone_id,
  )[0]
  name_servers = concat(
    aws_route53_zone.private.*.name_servers,
    aws_route53_zone.public.*.name_servers,
  )[0]
  # convert from list to map with unique keys
  record_set = { for rs in var.record_set : join(" ", compact(["${rs.name} ${rs.type}", lookup(rs, "set_identifier", "")])) => rs }
}

resource "aws_route53_zone" "public" {
  count         = var.vpc_id == "" ? 1 : 0
  name          = var.zone_name
  comment       = var.comment
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_route53_zone" "private" {
  count         = var.vpc_id != "" ? 1 : 0
  name          = var.zone_name
  comment       = var.comment
  force_destroy = var.force_destroy
  vpc {
    vpc_id = var.vpc_id
  }
  tags = var.tags
}

# resource "aws_route53_zone_association" "secondary" {
#   count   = var.vpc_id != "" ? 1 : 0
#   zone_id = aws_route53_zone.private[count.index].zone_id
#   vpc_id  = var.vpc_id
# }

resource "aws_route53_record" "record_set" {
  for_each = local.record_set
  zone_id  = local.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = lookup(each.value, "ttl", null)
  records  = lookup(each.value, "records", null)

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.dns_name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }
}
