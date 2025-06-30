# severless-azure-data-pipeline

# 📊 Serverless Real-Time Data Pipeline on Azure with Terraform & Python

This project builds a **serverless real-time data pipeline on Azure** using **Terraform** and **Python**, inspired by [this AWS pipeline guide](https://towardsaws.com/building-a-serverless-real-time-data-pipeline-with-terraform-aws-and-python-07111302ec52).

It processes real-time data, stores it securely, and runs transformations for analytics, fully automated by Terraform.

---

## ⚙️ **Architecture**

- **Azure Blob Storage**: stores incoming data files (e.g., CSV, JSON)
- **Azure Event Grid**: monitors blob events and triggers compute
- **Azure Functions (Python)**: serverless compute to process & transform data
- **Azure Event Hubs**: ingests and streams real-time events
- **Azure Stream Analytics**: transforms and routes streaming data
- **Azure Synapse Analytics**: data warehouse for analytics
- **Azure Key Vault**: securely manages secrets & credentials
- **Azure Monitor / Log Analytics**: centralized logging & monitoring

All infrastructure is defined and deployed using **Terraform**.

---

## 🛠 **Project Structure**

├── main.tf # Core Terraform resources
├── variables.tf # Input variables and validation
├── terraform.tfvars # Environment-specific values (DO NOT commit secrets)
├── outputs.tf # Outputs from deployment
├── azure function/ # Python code for Azure Functions
├── .gitlab-ci.yml # GitLab CI/CD pipeline
└── README.md


---

## 🚀 **How it works**

1. New data files uploaded to **Azure Blob Storage**
2. **Event Grid** detects blob creation and triggers **Azure Function**
3. Function processes the file and sends records to **Event Hubs**
4. **Stream Analytics** reads from Event Hubs, performs transformations
5. Cleaned data is loaded into **Synapse Analytics** for reporting
6. Secrets and credentials are stored securely in **Azure Key Vault**

---

## ✅ **Deployment**

1. **Create an Azure service principal** and save credentials in GitLab CI/CD variables:
   - `ARM_CLIENT_ID`
   - `ARM_CLIENT_SECRET`
   - `ARM_SUBSCRIPTION_ID`
   - `ARM_TENANT_ID`

2. **Clone this repository**:
   ```bash
   git clone https://gitlab.com/victoranolu/severless-azure-data-pipeline.git
   cd serverless-azure-pipeline

3. **Deploy Locally**
  - `terraform init`
  - `terraform validate`
  - `terraform plan`
  - `terraform apply`

4. **Security & Best Practices**
  - Secrets are stored in Azure Key Vault

  - Use managed identities to avoid hardcoding credentials

  - GitLab CI/CD pipeline enforces security through masked variables

  - .tfvars should never be committed if containing sensitive data

  - Use Terraform state encryption with Azure Storage backend

5. **Tech Stack**
   
   - Terraform

   - Azure Blob Storage

   - Azure Event Grid

   - Azure Functions (Python)

   - Azure Event Hubs

   - Azure Stream Analytics

   - Azure Synapse Analytics

   - Azure Key Vault

   - GitLab CI/CD
