# AWS Terraform state manager

This repository is for setting up and managing AWS resources required for Terraform state management.

## Usage

### Prerequisites

- [Taskfile](https://taskfile.dev) must be installed.
- [mise](https://mise.jdx.dev) must be installed.
- [AWS CLI](https://aws.amazon.com/cli/) must be installed and authenticated with the AWS account to be used for state management.

### Initialization

1. Copy `terraform/terraform.tfvars.example` and fill in the required configuration values (described below).

    ```bash
    cp terraform/terraform.tfvars.example terraform/terraform.tfvars
    ```

2. Initialize Terraform.

    ```bash
    task tf:init
    ```

### Adding a Project

1. Add a project to `locals.projects` in `terraform/projects.tf`.

2. Check the code.

    ```bash
    task tf:check
    ```

3. Review the changes to be applied.

    ```bash
    task tf:plan
    ```

4. Apply the changes.

    ```bash
    task tf:apply
    ```

### Removing a Project

1. Remove the project from `locals.projects` in `terraform/projects.tf`.

2. Check the code.

    ```bash
    task tf:check
    ```

3. Review the changes to be applied.

    ```bash
    task tf:plan
    ```

4. Destroy the resources.

    ```bash
    task tf:destroy
    ```

## Configuration Values

| Item | Required | Description |
| :- | :- | :- |
| `aws_account_id` | Yes | AWS account ID to use for state management |
| `aws_region` | No | AWS region to use for state management (default: `ap-northeast-1`) |

## Notes

- This repository should be applied only once initially for a given project. It is not intended for repeated execution.
- Deletion will result in the loss of Terraform state.
- S3 bucket names must be globally unique. If a conflict occurs, consider using a different name.
