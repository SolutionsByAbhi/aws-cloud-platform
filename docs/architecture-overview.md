
---

##  `docs/architecture-overview.md`

```markdown
#  Architecture  Overview

This  platform  models  a typical  production-ready  AWS  workload:

-  Internet-facing  ALB
-  Stateless application  tier  on  ECS  Fargate
-  Stateful  data  tier  on Amazon  RDS
-  Bastion  host for  controlled  admin  access
- Centralized  logging  and  metrics

The  design  emphasizes:

- Fault  isolation  via  subnets  and security  groups
-  Clear  separation of  public,  private,  and  data tiers
-  Infrastructure  as  Code with  Terraform  modules
-  Configuration as  Code  with  Ansible
