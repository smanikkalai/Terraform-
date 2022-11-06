variable "vpcName" {
    description = "Please write your VPC Name : "
}

variable "region" {
    type = string
    description = "Enter your region us-East :: us-West :: "
    
}

variable "vpccidr" {
    description = "enter your CIDR values here : "
}

variable "CMS_public_subnets" {
    type = list(string)
    description = "public Subnet CIDR values"
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "CMS_private_subnets" {
    type = list(string)
    description = "private subnetCIDR values"
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "az" {
    type = list(string)
    description = "select your region : "
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}


