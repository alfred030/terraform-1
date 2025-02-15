# Work with TRANSFER via terraform

A terraform module for making TRANSFER.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "transfer" {
  source      = "../../modules/transfer"
  name        = "TEST"
  environment = "stage"

  # transfer server
  enable_transfer_server        = true
  transfer_server_endpoint_type = "PUBLIC"
  transfer_server_logging_role  = "arn:aws:iam::167127734783:role/AllowS3FullAccess"

  # transfer user
  enable_transfer_user = true
  transfer_user_name   = "transfer_user_name"
  transfer_user_role   = "arn:aws:iam::167127734783:role/AllowS3FullAccess"

  # transfer ssh key
  enable_transfer_ssh_key = true
  transfer_ssh_key_body   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 example@linux-notes.org"

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_transfer_server` - Enable transfer server usage (`default = False`)
- `transfer_server_endpoint_type` - (Optional) The type of endpoint that you want your SFTP server connect to. If you connect to a VPC_ENDPOINT, your SFTP server isn't accessible over the public internet. If you want to connect your SFTP server via public internet, set PUBLIC. Defaults to PUBLIC. (`default = PUBLIC`)
- `transfer_server_invocation_role` - (Optional) Amazon Resource Name (ARN) of the IAM role used to authenticate the user account with an identity_provider_type of API_GATEWAY. (`default = null`)
- `transfer_server_host_key` - (Optional) RSA private key (e.g. as generated by the ssh-keygen -N '' -f my-new-server-key command). (`default = null`)
- `transfer_server_url` - (Optional) - URL of the service endpoint used to authenticate users with an identity_provider_type of API_GATEWAY. (`default = null`)
- `transfer_server_identity_provider_type` - (Optional) The mode of authentication enabled for this service. The default value is SERVICE_MANAGED, which allows you to store and access SFTP user credentials within the service. API_GATEWAY indicates that user authentication requires a call to an API Gateway endpoint URL provided by you to integrate an identity provider of your choice. (`default = null`)
- `transfer_server_logging_role` - (Optional) Amazon Resource Name (ARN) of an IAM role that allows the service to write your SFTP users’ activity to your Amazon CloudWatch logs for monitoring and auditing purposes. (`default = null`)
- `transfer_server_force_destroy` - (Optional) A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error. The default value is false. (`default = False`)
- `transfer_server_endpoint_details` - (Optional) The virtual private cloud (VPC) endpoint settings that you want to configure for your SFTP server. (`default = []`)
- `transfer_server_name` - Set transfer server name (`default = ""`)
- `enable_transfer_user` - Enable transfer user usage (`default = False`)
- `transfer_user_server_id` - The Server ID of the Transfer Server (e.g. s-12345678) (`default = ""`)
- `transfer_user_name` - The name used for log in to your SFTP server. (`default = ""`)
- `transfer_user_role` - (Requirement) Amazon Resource Name (ARN) of an IAM role that allows the service to controls your user’s access to your Amazon S3 bucket. (`default = null`)
- `transfer_user_home_directory` - (Optional) The landing directory (folder) for a user when they log in to the server using their SFTP client. It should begin with a /. The first item in the path is the name of the home bucket (accessible as 'Transfer:HomeBucket' in the policy) and the rest is the home directory (accessible as 'Transfer:HomeDirectory' in the policy). For example, /example-bucket-1234/username would set the home bucket to example-bucket-1234 and the home directory to username. (`default = null`)
- `transfer_user_policy` - (Optional) An IAM JSON policy document that scopes down user access to portions of their Amazon S3 bucket. IAM variables you can use inside this policy include 'Transfer:UserName', 'Transfer:HomeDirectory', and 'Transfer:HomeBucket'. Since the IAM variable syntax matches Terraform's interpolation syntax, they must be escaped inside Terraform configuration strings ('Transfer:UserName'). These are evaluated on-the-fly when navigating the bucket. (`default = null`)
- `enable_transfer_ssh_key` - Enable transfer ssh key usage (`default = False`)
- `transfer_ssh_key_server_id` - The Server ID of the Transfer Server (e.g. s-12345678) (`default = ""`)
- `transfer_ssh_key_user_name` - The name of the user account that is assigned to one or more servers. (`default = ""`)
- `transfer_ssh_key_body` - (Requirement) The public key portion of an SSH key pair. (`default = null`)

## Module Output Variables
----------------------
- `transfer_server_id` - The Server ID of the Transfer Server (e.g. s-12345678)
- `transfer_server_arn` - Amazon Resource Name (ARN) of Transfer Server
- `transfer_server_endpoint` - The endpoint of the Transfer Server (e.g. s-12345678.server.transfer.REGION.amazonaws.com)
- `transfer_server_host_key_fingerprint` - This value contains the message-digest algorithm (MD5) hash of the server's host key. This value is equivalent to the output of the ssh-keygen -l -E md5 -f my-new-server-key command.
- `transfer_user_id` - The Server ID of the Transfer user
- `transfer_user_arn` - Amazon Resource Name (ARN) of Transfer User
- `transfer_ssh_key_id` - The Server ID of the Transfer ssh key


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
