### Demo hierarchy:

```
account
 ├ account.hcl
 └ region
    ├ region.hcl
    └ project
       ├ project.hcl
       └ resources
          └ ...
```

- **Account**: Root level account used. E.g `dev`, `prod`, `staging`. The `account.hcl` file should contain the AWS account id and name.
- **Region**: Definition of the region. E.g `us-east-1`, `us-west-2`. The `region.hcl` file should contain the AWS region.
- **Project**: The task code for the project, should encompass the resources being deployed. The `project.hcl` file should contain the project code.
- **Resources**: The resources being deployed for the project. Resources can be broken down into subfolders depending on the complexity of the project. E.g. `services` for any ec2 instances and `vpc`.
