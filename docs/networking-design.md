#  Networking  Design

##  VPC

- One  VPC  per  environment  (e.g., `dev`,  `prod`)
-  CIDR:  `10.0.0.0/16` (configurable)

##  Subnets

-  **Public  subnets**:  ALB,  bastion
-  **Private  subnets**:  ECS  tasks
-  **Isolated  subnets**:  RDS

Each  subnet  is  spread  across at  least  two  Availability  Zones.

##  Routing

- Public  subnets  route  to  Internet Gateway
-  Private  subnets  route to  NAT  Gateway
-  Isolated subnets  have  no  direct  internet route

##  Security  Groups

-  ALB  SG:  inbound 80/443  from  internet,  outbound  to ECS  SG
-  ECS  SG: inbound  from  ALB  SG,  outbound to  RDS  SG
-  RDS SG:  inbound  from  ECS  SG only
-  Bastion  SG:  inbound SSH  from  trusted  IPs  or via  SSM
