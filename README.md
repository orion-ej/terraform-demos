## Demos

- **session-1**: Makes use of [terragrunt](https://terragrunt.gruntwork.io/) to implement a folder structure for terraform that defines the scope for accounts, regions, and projects. Module definitions are defined externally via git and can be versioned and updated independently of the project code. See [Modules](https://github.com/orion-ej/modules-demo).
- **session-2**: Plain terraform demos that walk through the basics of terraform
  - demo-1: Deploy a single ec2 instance
  - demo-2: Define remote state and deploy a web cluster (instances, alb, security groups, etc)
  - demo-3: Define a local module and deploy 2 ec2 instances
