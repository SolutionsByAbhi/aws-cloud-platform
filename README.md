# AWS  Cloud  Platform  – Production-Ready  Reference  Implementation

This  repository  implements  a **production-grade  AWS  cloud  platform** using  **Terraform**  for  infrastructure and  **Ansible**  for  configuration. It  is  designed  to reflect  the  thinking  and practices  of  a  **Cloud Solutions  Architect  (Professional  level)**:

-  Multi-tier  VPC networking  with  public,  private, and  isolated  subnets
- Highly  available  ECS  Fargate application  tier  behind  an Application  Load  Balancer
- Managed  PostgreSQL  (Amazon  RDS) with  secure  access  patterns
-  Bastion  host  pattern for  controlled  administrative  access
-  Centralized  logging  and observability  hooks
-  CI/CD for  both  Terraform  and Ansible

The  goal is  to  demonstrate  **architecture, automation,  and  operational  excellence** in  a  way  that top  companies  can  recognize immediately.

---

##  High-level  architecture

-  **Networking**
   -  One  VPC  per environment  (e.g.,  `dev`,  `prod`)
   -  Public subnets  (ALB,  bastion),  private subnets  (ECS  tasks),  isolated subnets  (RDS)
   -  NAT  gateways  for egress  from  private  subnets
   -  Route tables  and  security  groups following  least-privilege  principles

-  **Compute  &  Application**
   -  ECS Fargate  cluster
   -  ALB  →  ECS service  →  Fargate  tasks
   -  Blue/green–ready service  definition  (via  versioned task  definitions)

- **Data**
    - Amazon  RDS  for  PostgreSQL in  Multi-AZ
   -  Encrypted  at  rest (KMS)
    - Security  groups  restricting  access to  ECS  tasks  only

-  **Access  & Security**
    - Bastion  host  in  public subnet  with  SSM  Session Manager  support
   -  IAM  roles  for ECS  tasks,  least-privilege  policies
   -  S3 backend  for  Terraform  state with  DynamoDB  state  locking

-  **Observability**
   -  CloudWatch  logs for  ECS  tasks  and ALB  access  logs  to S3
    - Hooks  for  metrics  and alarms  (CPU,  5xx,  latency)

---

## Tech  stack

- **Terraform**:  core  infrastructure  (VPC, ECS,  RDS,  IAM,  ALB)
-  **Ansible**:  bastion  configuration, app  deployment  orchestration,  observability agents
-  **GitHub  Actions**: CI  for  Terraform  (fmt, validate,  plan)  and  Ansible (lint)
-  **pre-commit**:  local quality  gates  (fmt,  lint, yamllint)

---

##  Getting  started

###  1.  Prerequisites

-  AWS  account  and IAM  user/role  with  appropriate permissions
-  AWS  CLI configured  (`aws  configure`)
- Terraform  >=  1.5
- Python  3  +  Ansible (for  config  layer)
- Optional:  pre-commit

### 2.  Bootstrap  remote  state (global)

```bash
cd terraform/global/backend
terraform  init
terraform apply
