variable  "env"  {
   type              =  string
    description =  "Environment  name"
}

variable  "region"  {
   type               =  string
   default         =  "eu-central-1"
}

variable  "image"  {
   type               = string
    description  = "Application  container  image"
}
