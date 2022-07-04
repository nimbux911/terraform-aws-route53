# terraform-aws-route53
Terraform module to create route 53 hosted zones.

## Usages

### Example for public zone:

```hcl
module "public_zone_name" {
    source    = "git@github.com:nimbux911/terraform-aws-route53/tags/v1.0"
    zone_name = "name."

        record_set = [ {
        record_name = "name."
        type        = "A" // Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT
        ttl         = 300 
        records     = ["IP"]
    } ]

    tags = {
        Environment  = var.environment
        Purpose     = "Api endpoint"
    }
}
```

### Example for private zone:

```hcl
module "private_zone_name" {
    source    = "git@github.com:nimbux911/terraform-aws-route53/tags/1.0"
    zone_name = "name."
    vpc_id    = "vpc-id"
    record_set = [ {
        record_name = "name."
        type        = "A" // Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT
        ttl         = 300 
        records     = ["IP"]
    } ]

    tags = {
        Environment  = var.environment
        Purpouse     = "Api endpoint"
    }
}
```


## Outputs

| Name | Description |
|------|-------------|
| zone_id | The ID of Hosted Zone |
| name_servers | A list of name servers in associated (or default) delegation set |
| zone_name | Route53 Hosted Zone domain name |