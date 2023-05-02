# azure.webapplication.challenge

## About this repo

This repo includes all the resources required in Azure to get the aspnetcore application up and running. There are two main directories in the repo, one that includes the application code and a second one which has the infrastrucure configuration in Terraform. Both the nfrastructure provisioninng and the deployment of the application are automated using Azure DevOps pipelines. 

```
.
├── README.md
├── application
│   └── aspnetcoreapp
├── deploy-webapp.yml
├── disaster-recovery.yml
├── infrastructure
│   ├── core
│   │   ├── appservice.tf
│   │   ├── azuresql.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── variables.tf
│   └── dr
│       ├── appservice.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── variables.tf
└── infrastructure-provisioning.yml
```

### Infrastructure Provisioning

The application's infrastructure consists of an Azure App Service for hosting the application, and Azure SQL server and database which the server connects to. These resources are described as IaC under `infrastructure/core`. The pipeline used to deploy these resources is `infrastructure-provisioning.yml` and consists of the following steps:

- Terrafor Validate, in which the terraform is initalized and the configuration is validated.
- Terraform Apply, in which after initializing, terraform creates a plan and then it applies it to create the resources on Azure.


### Web App Deployment

Once the infrastructure is ready the pipeline `Deploy Web App`, `deploy-webapp.yml` has to be triggered in order to deploy the application on the server. This includes the following steps:

- Run `dotnet build` to build the project and create a package.
- The package is published as an artifact in the Azure pipeline's project.
- The published artifact is pulled and deployed on the App Service.

### Disaster Recovery

There is a DR proceedure configured for the case of a region failure in the cloud provider. 

Firstly, the database is configured to automatically start performing a failover to the secondary database grcefully 60 minutes after the primary is lost. Next, the pipeline, `disaster-recovery.yml` has to be triggered to deploy a new App Service in a new region. This pipeline is condidering the resources under `infrestructure/dr`. Once the latter is completed successfully, the `deploy-webapp.yml` pipeline will be automatically retriggered and deploly the application on the new App Service. Soon after that the application will be back up and running in a new region.
