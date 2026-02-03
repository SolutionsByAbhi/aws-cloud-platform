variable  "name"  {
   type               =  string
   description  =  "Name prefix  for  the  VPC"
}

variable  "cidr_block"  {
   type               = string
    description  = "CIDR  block  for  the  VPC"
}

variable  "public_subnet_cidrs"  {
   type              =  list(string)
    description =  "CIDRs  for  public  subnets"
}

variable  "private_subnet_cidrs"  {
   type              =  list(string)
    description =  "CIDRs  for  private  subnets"
}

variable  "isolated_subnet_cidrs"  {
   type              =  list(string)
    description =  "CIDRs  for  isolated  subnets"
}

variable  "azs"  {
   type              =  list(string)
    description =  "Availability  Zones"
}

variable  "tags"  {
   type               =  map(string)
   default         =  {}
   description  =  "Common  tags"
}
