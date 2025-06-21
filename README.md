# Global Terraform

Create a tf-globals repos and terraform the S3 bucket for the frontend static assets.  
The bucket name should include the environment name, ie development / staging / production / etc  


**Goal:**

    Create global S3 bucket(s) for frontend static assets, managed in a tf-globals repo.

**Action:**

    terraform apply in tf-globals → creates the S3 bucket(s).

    Bucket names should include the environment  
    (development, staging, production, etc.) → e.g., frontend-assets-development

**Outcome:** 

    Bucket(s) ready before other Terraform projects reference them.

