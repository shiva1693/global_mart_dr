variable "domain_name" { 
    type = string 
    description = "The custom domain name to use for the API Gateway.\nThis should be a subdomain of the hosted zone specified by zone_id(Ex.api.dr.example.com if the hosted zone is example.com)"
}

variable "tags" { 
    type = map(string) 
}

variable "zone_id" { 
    type = string 
    description = "The Route53 hosted zone ID for the custom domain"
}

variable "primary_region" { 
    type = string 
    description = "The primary region where the API Gateway is deployed"
}

variable "secondary_region" { 
    type = string 
    description = "The secondary region where the API Gateway is deployed"
}

variable "primary_rest_api_id" { 
    type = string 
    description = "The ID of the primary API Gateway REST API to map the custom domain to"
}
variable "secondary_rest_api_id" { 
    type = string 
    description = "The ID of the secondary API Gateway REST API to map the custom domain to"
}

variable "primary_stage_name" { 
    type = string 
    description = "The stage name of the primary API Gateway to map the custom domain to"
}

variable "secondary_stage_name" { 
    type = string 
    description = "The stage name of the secondary API Gateway to map the custom domain to"
}