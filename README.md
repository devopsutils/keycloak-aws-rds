## keycloak-aws-rds

A sample Terraform setup for creating a Keycloak ECS instance behind an ALB

# What

This project demonstrates how to launch an instance of [KeyCloak](https://keycloak.org) with a PostgreSQL [RDS](https://aws.amazon.com/rds/) backend within your AWS [VPC](https://aws.amazon.com/vpc/) using [Terraform](https://terraform.io).  These modules will deploy KeyCloak within a Docker container deployed on EC2, accessible behind an [ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html).  A DNS record for the instance will also be created using [Route 53](https://aws.amazon.com/route53/) and a corresponding certificate for the ALB will be created and applied using [ACM](https://aws.amazon.com/certificate-manager/).

# Getting Started

This code has been tested using Terraform 0.12.0.  If you are running a newer version of Terraform, you may need to make some changes and tweaks.  After cloning this repo, within the source directory run:

```
terraform init
```

This will ensure that the modules are registered and any required providers are downloaded.  Now that the build environment is initialized, you must define the values for the variables needed by the Terraform modules.  You may either do this as `terraform apply` is run, or you may use a var file.  To use a var file (in this case, called `private.tfvars`) simple run:

```
terraform plan -var-file=private.tfvars
```

If everything in the plan looks appropriate, you may apply the Terraform module and begin building out your infrastructure by running:

```
terraform apply -var-file=private.tfvars
```

# Testing it out

Once your Terraform build completes, you will see outputs showing the ALB's DNS name, as well as the DNS name created using Route 53.  Wait a couple seconds for the ALB to register the backend target, and then open up a browser to either of those values.  You should see the KeyCloak login page appear.  Login with the administrator username and password you provided as part of your Terraform variables.

# Caveats

A few caveats, particularly related to security...

#### Route 53 and DNS

This deployment assumes that you have an existing Route 53 zone setup for your domain.  The DNS record for KeyCloak will created in this zone during ```apply```, but the zone itself must exist beforehand.

#### Clustering

This deployment -- while behind an ALB -- only results in a single KeyCloak instance.  If you'd like to see how to deploy a full auto-scaling KeyCloak cluster with the same RDS and ALB support, take a look at [this repo](https://github.com/sdnakhla/keycloak-cluster-aws-rds).

#### RDS Credentials

Due to shortcomings in the way that the KeyCloak Docker image and underlying application server work, RDS credentials are provided as part of the ECS task definition and made available to KeyClok as environment variables.  This is less than ideal, but I'm not knowledgeable enough on Terraform to come up with a better way.  If you have one, feel free to raise an issue or submit a pull request!

#### RDS Database Engine

This code is based off of an RDS instance running PostgreSQL.  It's likely that you could change the database engine to MySQL or another database supported by KeyCloak, but this functionality has not been tested.

# Questions/Issues

Find a bug?  Have an idea on how to better implement a section of the code?  Have a general question?  Feel free to raise an issue or submit a pull request!  I can't guarantee that I have all the answers, as this project is really just an exercise to help me learn Terraform better.  But I'll certainly give it my best shot.