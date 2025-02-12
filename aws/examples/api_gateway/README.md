# Work with API_GATEWAY via terraform

A terraform module for making API_GATEWAY.


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

module "api_gateway" {
  source      = "../../modules/api_gateway"
  name        = "TEST"
  environment = "stage"

  # API gateway rest api
  enable_api_gateway_rest_api = true
  api_gateway_rest_api_name   = ""

  # API gateway resource
  enable_api_gateway_resource    = true
  api_gateway_resource_path_part = "path-part"

  # API gateway method
  enable_api_gateway_method        = true
  api_gateway_method_http_method   = "ANY"
  api_gateway_method_authorization = "NONE"

  # API gateway method
  enable_api_gateway_documentation_part     = true
  api_gateway_documentation_part_properties = "{\"description\":\"Example description\"}"

  api_gateway_documentation_part_location = [
    {
      type   = "METHOD"
      method = "GET"
      path   = "/example"
    }
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_api_gateway_account` - Enable api gateway account usage (`default = False`)
- `api_gateway_account_cloudwatch_role_arn` - (Optional) The ARN of an IAM role for CloudWatch (to allow logging & monitoring). See more in AWS Docs. Logging & monitoring can be enabled/disabled and otherwise tuned on the API Gateway Stage level. (`default = null`)
- `enable_api_gateway_api_key` - Enable api gateway api key usage (`default = False`)
- `api_gateway_api_key_name` - The name of the API key (`default = ""`)
- `api_gateway_api_key_description` - (Optional) The API key description. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `api_gateway_api_key_enabled` - (Optional) Specifies whether the API key can be used by callers. Defaults to true. (`default = True`)
- `api_gateway_api_key_value` - (Optional) The value of the API key. If not specified, it will be automatically generated by AWS on creation. (`default = null`)
- `enable_api_gateway_rest_api` - Enable api gateway rest api usage (`default = False`)
- `api_gateway_rest_api_name` - The name of the REST API (`default = ""`)
- `api_gateway_rest_api_description` - (Optional) The description of the REST API (`default = null`)
- `api_gateway_rest_api_binary_media_types` - (Optional) The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads. (`default = null`)
- `api_gateway_rest_api_minimum_compression_size` - (Optional) Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default). (`default = ${-1}`)
- `api_gateway_rest_api_body` - (Optional) An OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. (`default = null`)
- `api_gateway_rest_api_policy` - (Optional) JSON formatted policy document that controls access to the API Gateway. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (`default = null`)
- `api_gateway_rest_api_api_key_source` - (Optional) The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. (`default = HEADER`)
- `api_gateway_rest_api_endpoint_configuration` - (Optional) Nested argument defining API endpoint configuration including endpoint type. (`default = []`)
- `enable_api_gateway_authorizer` - Enable api gateway authorizer usage (`default = False`)
- `api_gateway_authorizer_name` - The name of the authorizer (`default = ""`)
- `api_gateway_authorizer_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_authorizer_authorizer_uri` - (Optional, required for type TOKEN/REQUEST) The authorizer's Uniform Resource Identifier (URI). This must be a well-formed Lambda function URI in the form of arn:aws:apigateway:{region}:lambda:path/{service_api}, e.g. arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:012345678912:function:my-function/invocations (`default = null`)
- `api_gateway_authorizer_authorizer_credentials` - (Optional) The credentials required for the authorizer. To specify an IAM Role for API Gateway to assume, use the IAM Role ARN. (`default = null`)
- `api_gateway_authorizer_authorizer_result_ttl_in_seconds` - (Optional) The TTL of cached authorizer results in seconds. Defaults to 300. (`default = 300`)
- `api_gateway_authorizer_identity_source` - (Optional) The source of the identity in an incoming request. Defaults to method.request.header.Authorization. For REQUEST type, this may be a comma-separated list of values, including headers, query string parameters and stage variables - e.g. (`default = null`)
- `api_gateway_authorizer_type` - (Optional) The type of the authorizer. Possible values are TOKEN for a Lambda function using a single authorization token submitted in a custom header, REQUEST for a Lambda function using incoming request parameters, or COGNITO_USER_POOLS for using an Amazon Cognito user pool. Defaults to TOKEN. (`default = TOKEN`)
- `api_gateway_authorizer_identity_validation_expression` - (Optional) A validation expression for the incoming identity. For TOKEN type, this value should be a regular expression. The incoming token from the client is matched against this expression, and will proceed if the token matches. If the token doesn't match, the client receives a 401 Unauthorized response. (`default = null`)
- `api_gateway_authorizer_provider_arns` - (Optional, required for type COGNITO_USER_POOLS) A list of the Amazon Cognito user pool ARNs. Each element is of this format: arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}. (`default = null`)
- `enable_api_gateway_vpc_link` - Enable api gateway vpc link usage (`default = False`)
- `api_gateway_vpc_link_name` - The name used to label and identify the VPC link. (`default = ""`)
- `api_gateway_vpc_link_target_arns` - (Required, ForceNew) The list of network load balancer arns in the VPC targeted by the VPC link. Currently AWS only supports 1 target. (`default = null`)
- `api_gateway_vpc_link_description` - (Optional) The description of the VPC link. (`default = null`)
- `enable_api_gateway_resource` - Enable api gateway resource usage (`default = False`)
- `api_gateway_resource_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_resource_parent_id` - The ID of the parent API resource (`default = ""`)
- `api_gateway_resource_path_part` - (Required) The last path segment of this API resource. (`default = null`)
- `enable_api_gateway_request_validator` - Enable api gateway request validator usage (`default = False`)
- `api_gateway_request_validator_name` - The name of the request validator (`default = ""`)
- `api_gateway_request_validator_rest_api_id` - The ID of the associated Rest API (`default = ""`)
- `api_gateway_request_validator_validate_request_body` - (Optional) Boolean whether to validate request body. Defaults to false. (`default = False`)
- `api_gateway_request_validator_validate_request_parameters` - (Optional) Boolean whether to validate request parameters. Defaults to false. (`default = False`)
- `enable_api_gateway_model` - Enable api gateway model usage (`default = False`)
- `api_gateway_model_name` - The name of the model (`default = ""`)
- `api_gateway_model_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_model_content_type` - (Required) The content type of the model (`default = null`)
- `api_gateway_model_schema` - (Required) The schema of the model in a JSON form (`default = null`)
- `api_gateway_model_description` - (Optional) The description of the model (`default = null`)
- `enable_api_gateway_method` - Enable api gateway method usage (`default = False`)
- `api_gateway_method_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_method_resource_id` - The API resource ID (`default = ""`)
- `api_gateway_method_http_method` - (Required) The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY) (`default = GET`)
- `api_gateway_method_authorization` - (Required) The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS) (`default = NONE`)
- `api_gateway_method_authorizer_id` - (Optional) The authorizer id to be used when the authorization is CUSTOM or COGNITO_USER_POOLS (`default = null`)
- `api_gateway_method_authorization_scopes` - (Optional) The authorization scopes used when the authorization is COGNITO_USER_POOLS (`default = null`)
- `api_gateway_method_api_key_required` - (Optional) Specify if the method requires an API key (`default = null`)
- `api_gateway_method_request_models` - Optional) A map of the API models used for the request's content type where key is the content type (e.g. application/json) and value is either Error, Empty (built-in models) or aws_api_gateway_model's name. (`default = null`)
- `api_gateway_method_request_validator_id` - (Optional) The ID of a aws_api_gateway_request_validator (`default = null`)
- `api_gateway_method_request_parameters` - (Optional) A map of request parameters (from the path, query string and headers) that should be passed to the integration. The boolean value indicates whether the parameter is required (true) or optional (false). For example: request_parameters = {'method.request.header.X-Some-Header' = true 'method.request.querystring.some-query-param' = true} would define that the header X-Some-Header and the query string some-query-param must be provided in the request. (`default = null`)
- `enable_api_gateway_method_response` - Enable api gateway method response usage (`default = False`)
- `api_gateway_method_response_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_method_response_resource_id` - The API resource ID (`default = ""`)
- `api_gateway_method_response_http_method` - The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY) (`default = ""`)
- `api_gateway_method_response_status_code` - (Required) The HTTP status code (`default = 200`)
- `api_gateway_method_response_response_models` - (Optional) A map of the API models used for the response's content type (`default = null`)
- `api_gateway_method_response_response_parameters` - (Optional) A map of response parameters that can be sent to the caller. For example: response_parameters = { 'method.response.header.X-Some-Header' = true } would define that the header X-Some-Header can be provided on the response. (`default = null`)
- `enable_api_gateway_integration` - Enable api gateway integration usage (`default = False`)
- `api_gateway_integration_rest_api_id` - The ID of the associated REST API. (`default = ""`)
- `api_gateway_integration_resource_id` - The API resource ID. (`default = ""`)
- `api_gateway_integration_http_method` - The HTTP method (GET, POST, PUT, DELETE, HEAD, OPTION, ANY) when calling the associated resource. (`default = ""`)
- `api_gateway_integration_type` - (Required) The integration input's type. Valid values are HTTP (for HTTP backends), MOCK (not calling any real backend), AWS (for AWS services), AWS_PROXY (for Lambda proxy integration) and HTTP_PROXY (for HTTP proxy integration). An HTTP or HTTP_PROXY integration with a connection_type of VPC_LINK is referred to as a private integration and uses a VpcLink to connect API Gateway to a network load balancer of a VPC. (`default = null`)
- `api_gateway_integration_integration_http_method` - (Optional) The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY. Not all methods are compatible with all AWS integrations. e.g. Lambda function can only be invoked via POST. (`default = null`)
- `api_gateway_integration_connection_type` - (Optional) The integration input's connectionType. Valid values are INTERNET (default for connections through the public routable internet), and VPC_LINK (for private connections between API Gateway and a network load balancer in a VPC). (`default = null`)
- `api_gateway_integration_connection_id` - (Optional) The id of the VpcLink used for the integration. Required if connection_type is VPC_LINK (`default = null`)
- `api_gateway_integration_uri` - (Optional) The input's URI. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY. For HTTP integrations, the URI must be a fully formed, encoded HTTP(S) URL according to the RFC-3986 specification . For AWS integrations, the URI should be of the form arn:aws:apigateway:{region}:{subdomain.service|service}:{path|action}/{service_api}. region, subdomain and service are used to determine the right endpoint. e.g. arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:012345678901:function:my-func/invocations (`default = null`)
- `api_gateway_integration_credentials` - (Optional) The credentials required for the integration. For AWS integrations, 2 options are available. To specify an IAM Role for Amazon API Gateway to assume, use the role's ARN. To require that the caller's identity be passed through from the request. (`default = null`)
- `api_gateway_integration_request_templates` - (Optional) A map of the integration's request templates. (`default = null`)
- `api_gateway_integration_request_parameters` - (Optional) A map of request query string parameters and headers that should be passed to the backend responder. For example: request_parameters = { 'integration.request.header.X-Some-Other-Header' = 'method.request.header.X-Some-Header' } (`default = null`)
- `api_gateway_integration_passthrough_behavior` - (Optional) The integration passthrough behavior (WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER). Required if request_templates is used. (`default = null`)
- `api_gateway_integration_cache_key_parameters` - (Optional) A list of cache key parameters for the integration. (`default = null`)
- `api_gateway_integration_cache_namespace` - (Optional) The integration's cache namespace. (`default = null`)
- `api_gateway_integration_content_handling` - (Optional) Specifies how to handle request payload content type conversions. Supported values are CONVERT_TO_BINARY and CONVERT_TO_TEXT. If this property is not defined, the request payload will be passed through from the method request to integration request without modification, provided that the passthroughBehaviors is configured to support payload pass-through. (`default = null`)
- `api_gateway_integration_timeout_milliseconds` - (Optional) Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds. (`default = null`)
- `enable_api_gateway_integration_response` - Enable api gateway integration response usage (`default = False`)
- `api_gateway_integration_response_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_integration_response_resource_id` - The API resource ID (`default = ""`)
- `api_gateway_integration_response_http_method` - The HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY) (`default = ""`)
- `api_gateway_integration_response_status_code` - The HTTP status code (`default = ""`)
- `api_gateway_integration_response_selection_pattern` - (Optional) Specifies the regular expression pattern used to choose an integration response based on the response from the backend. Setting this to - makes the integration the default one. If the backend is an AWS Lambda function, the AWS Lambda function error header is matched. For all other HTTP and AWS backends, the HTTP status code is matched. (`default = null`)
- `api_gateway_integration_response_response_templates` - (Optional) A map specifying the templates used to transform the integration response body (`default = null`)
- `api_gateway_integration_response_response_parameters` - (Optional) A map of response parameters that can be read from the backend response. For example: response_parameters = { 'method.response.header.X-Some-Header' = 'integration.response.header.X-Some-Other-Header' } (`default = null`)
- `api_gateway_integration_response_content_handling` - (Optional) Specifies how to handle request payload content type conversions. Supported values are CONVERT_TO_BINARY and CONVERT_TO_TEXT. If this property is not defined, the response payload will be passed through from the integration response to the method response without modification. (`default = null`)
- `enable_api_gateway_gateway_response` - Enable api gateway gateway response usage (`default = False`)
- `api_gateway_gateway_response_rest_api_id` - The string identifier of the associated REST API. (`default = ""`)
- `api_gateway_gateway_response_response_type` - (Required) The response type of the associated GatewayResponse. (`default = ""`)
- `api_gateway_gateway_response_status_code` - (Optional) The HTTP status code of the Gateway Response. (`default = null`)
- `api_gateway_gateway_response_response_templates` - (Optional) A map specifying the templates used to transform the response body. (`default = null`)
- `api_gateway_gateway_response_response_parameters` - (Optional) A map specifying the parameters (paths, query strings and headers) of the Gateway Response. (`default = null`)
- `enable_api_gateway_domain_name` - Enable api gateway domain name usage (`default = False`)
- `api_gateway_domain_name_domain_name` - The fully-qualified domain name to register (`default = ""`)
- `api_gateway_domain_name_security_policy` - (Optional) The Transport Layer Security (TLS) version + cipher suite for this DomainName. The valid values are TLS_1_0 and TLS_1_2. Must be configured to perform drift detection. (`default = null`)
- `api_gateway_domain_name_certificate_arn` - (Optional) The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source. Used when an edge-optimized domain name is desired. Conflicts with certificate_name, certificate_body, certificate_chain, certificate_private_key, regional_certificate_arn, and regional_certificate_name. (`default = null`)
- `api_gateway_domain_name_certificate_name` - (Optional) The unique name to use when registering this certificate as an IAM server certificate. Conflicts with certificate_arn, regional_certificate_arn, and regional_certificate_name. Required if certificate_arn is not set. (`default = null`)
- `api_gateway_domain_name_certificate_body` - (Optional) The certificate issued for the domain name being registered, in PEM format. Only valid for EDGE endpoint configuration type. Conflicts with certificate_arn, regional_certificate_arn, and regional_certificate_name. (`default = null`)
- `api_gateway_domain_name_certificate_chain` - (Optional) The certificate for the CA that issued the certificate, along with any intermediate CA certificates required to create an unbroken chain to a certificate trusted by the intended API clients. Only valid for EDGE endpoint configuration type. Conflicts with certificate_arn, regional_certificate_arn, and regional_certificate_name. (`default = null`)
- `api_gateway_domain_name_certificate_private_key` - (Optional) The private key associated with the domain certificate given in certificate_body. Only valid for EDGE endpoint configuration type. Conflicts with certificate_arn, regional_certificate_arn, and regional_certificate_name. (`default = null`)
- `api_gateway_domain_name_regional_certificate_arn` - (Optional) The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source. Used when a regional domain name is desired. Conflicts with certificate_arn, certificate_name, certificate_body, certificate_chain, and certificate_private_key. (`default = null`)
- `api_gateway_domain_name_regional_certificate_name` - (Optional) The user-friendly name of the certificate that will be used by regional endpoint for this domain name. Conflicts with certificate_arn, certificate_name, certificate_body, certificate_chain, and certificate_private_key. (`default = null`)
- `api_gateway_domain_name_endpoint_configuration` - (Optional) Configuration block defining API endpoint information including type. (`default = []`)
- `enable_api_gateway_client_certificate` - Enable api gateway client certificate usage (`default = False`)
- `api_gateway_client_certificate_description` - (Optional) The description of the client certificate. (`default = null`)
- `enable_api_gateway_documentation_part` - Enable api gateway documentation part usage (`default = False`)
- `api_gateway_documentation_part_rest_api_id` - The ID of the associated Rest API (`default = ""`)
- `api_gateway_documentation_part_properties` - (Required) A content map of API-specific key-value pairs describing the targeted API entity. The map must be encoded as a JSON string, e.g. Only Swagger-compliant key-value pairs can be exported and, hence, published. (`default = null`)
- `api_gateway_documentation_part_location` - (Required) The location of the targeted API entity of the to-be-created documentation part. (`default = []`)
- `enable_api_gateway_documentation_version` - Enable api gateway documentation version usage (`default = False`)
- `api_gateway_documentation_version_rest_api_id` - The ID of the associated Rest API (`default = ""`)
- `api_gateway_documentation_version_version` - The version identifier of the API documentation snapshot. (`default = ""`)
- `api_gateway_documentation_version_description` - (Optional) The description of the API documentation version. (`default = null`)
- `enable_api_gateway_deployment` - Enable api gateway deployment usage (`default = False`)
- `api_gateway_deployment_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_deployment_stage_name` - (Optional) The name of the stage. If the specified stage already exists, it will be updated to point to the new deployment. If the stage does not exist, a new one will be created and point to this deployment. (`default = null`)
- `api_gateway_deployment_description` - (Optional) The description of the deployment (`default = null`)
- `api_gateway_deployment_stage_description` - (Optional) The description of the stage (`default = null`)
- `api_gateway_deployment_variables` - (Optional) A map that defines variables for the stage (`default = null`)
- `enable_api_gateway_stage` - Enable api gateway stage usage (`default = False`)
- `api_gateway_stage_rest_api_id` - The ID of the associated REST API (`default = ""`)
- `api_gateway_stage_deployment_id` - The ID of the deployment that the stage points to (`default = ""`)
- `api_gateway_stage_stage_name` - The name of the stage (`default = ""`)
- `api_gateway_stage_description` - (Optional) The description of the stage (`default = null`)
- `api_gateway_stage_cache_cluster_enabled` - (Optional) Specifies whether a cache cluster is enabled for the stage (`default = null`)
- `api_gateway_stage_cache_cluster_size` - (Optional) The size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237. (`default = null`)
- `api_gateway_stage_client_certificate_id` - (Optional) The identifier of a client certificate for the stage. (`default = null`)
- `api_gateway_stage_documentation_version` - (Optional) The version of the associated API documentation (`default = null`)
- `api_gateway_stage_variables` - (Optional) A map that defines the stage variables (`default = null`)
- `api_gateway_stage_xray_tracing_enabled` - (Optional) Whether active tracing with X-ray is enabled. Defaults to false. (`default = False`)
- `api_gateway_stage_access_log_settings` - (Optional) Enables access logs for the API stage. (`default = []`)
- `enable_api_gateway_base_path_mapping` - Enable api gateway base path mapping usage (`default = False`)
- `api_gateway_base_path_mapping_api_id` - The id of the API to connect. (`default = ""`)
- `api_gateway_base_path_mapping_domain_name` - The already-registered domain name to connect the API to. (`default = ""`)
- `api_gateway_base_path_mapping_stage_name` - (Optional) The name of a specific deployment stage to expose at the given path. If omitted, callers may select any stage by including its name as a path element after the base path. (`default = null`)
- `api_gateway_base_path_mapping_base_path` - (Optional) Path segment that must be prepended to the path when accessing the API via this mapping. If omitted, the API is exposed at the root of the given domain. (`default = null`)
- `enable_api_gateway_method_settings` - Enable api gateway method settings usage (`default = False`)
- `api_gateway_method_settings_rest_api_id` - The ID of the REST API (`default = ""`)
- `api_gateway_method_settings_stage_name` - The name of the stage (`default = ""`)
- `api_gateway_method_settings_method_path` - (Required) Method path defined as {resource_path}/{http_method} for an individual method override, or */* for overriding all methods in the stage. (`default = ""`)
- `api_gateway_method_settings_settings` - (Required) The settings block (`default = []`)
- `enable_api_gateway_usage_plan` - Enable api gateway usage plan usage (`default = False`)
- `api_gateway_usage_plan_name` - The name of the usage plan. (`default = ""`)
- `api_gateway_usage_plan_description` - (Optional) The description of a usage plan. (`default = null`)
- `api_gateway_usage_plan_product_code` - (Optional) The AWS Markeplace product identifier to associate with the usage plan as a SaaS product on AWS Marketplace. (`default = null`)
- `api_gateway_usage_plan_api_stages` - (Optional) The associated API stages of the usage plan. (`default = []`)
- `api_gateway_usage_plan_quota_settings` - (Optional) The quota settings of the usage plan. (`default = []`)
- `api_gateway_usage_plan_throttle_settings` - (Optional) The throttling limits of the usage plan. (`default = []`)
- `enable_api_gateway_usage_plan_key` - Enable api gateway usage plan key usage (`default = False`)
- `api_gateway_usage_plan_key_key_id` - The identifier of the API key resource. (`default = ""`)
- `api_gateway_usage_plan_key_key_type` - (Required) The type of the API key resource. Currently, the valid key type is API_KEY. (`default = API_KEY`)
- `api_gateway_usage_plan_key_usage_plan_id` - The Id of the usage plan resource representing to associate the key to. (`default = ""`)

## Module Output Variables
----------------------
- `api_gateway_account_id` - The ID of the apy gateway account
- `api_gateway_api_key_id` - The ID of the API key
- `api_gateway_api_key_created_date` - The creation date of the API key
- `api_gateway_api_key_last_updated_date` - The last update date of the API key
- `api_gateway_api_key_value` - The value of the API key
- `api_gateway_api_key_arn` - Amazon Resource Name (ARN)
- `api_gateway_rest_api_id` - The ID of the REST API
- `api_gateway_rest_api_root_resource_id` - The resource ID of the REST API's root
- `api_gateway_rest_api_created_date` - The creation date of the REST API
- `api_gateway_rest_api_execution_arn` - The execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j, which can be concatenated with allowed stage, method and resource path.
- `api_gateway_rest_api_arn` - Amazon Resource Name (ARN)
- `api_gateway_authorizer_id` - The ID of the GW authorizer
- `api_gateway_vpc_link` - The identifier of the VpcLink.
- `api_gateway_resource_id` - The resource's identifier.
- `api_gateway_resource_path` - The complete path for this API resource, including all parent paths.
- `api_gateway_request_validator_id` - The unique ID of the request validator
- `api_gateway_model_id` - The ID of the model
- `api_gateway_method_id` - The ID of the method
- `api_gateway_method_response_id` - The ID of the method response
- `api_gateway_integration_id` - The ID of the integration
- `api_gateway_integration_response_id` - The ID of the integration response
- `api_gateway_gateway_response_id` - The ID of the gateway response
- `api_gateway_domain_name_id` - The internal id assigned to this domain name by API Gateway.
- `api_gateway_domain_name_certificate_upload_date` - The upload date associated with the domain certificate.
- `api_gateway_domain_name_cloudfront_domain_name` - The hostname created by Cloudfront to represent the distribution that implements this domain name mapping.
- `api_gateway_domain_name_cloudfront_zone_id` - For convenience, the hosted zone ID (Z2FDTNDATAQYW2) that can be used to create a Route53 alias record for the distribution.
- `api_gateway_domain_name_regional_zone_id` - The hosted zone ID that can be used to create a Route53 alias record for the regional endpoint.
- `api_gateway_domain_name_arn` - Amazon Resource Name (ARN)
- `api_gateway_client_certificate_id` - The identifier of the client certificate.
- `api_gateway_client_certificate_created_date` - The date when the client certificate was created.
- `api_gateway_client_certificate_expiration_date` - The date when the client certificate will expire.
- `api_gateway_client_certificate_pem_encoded_certificate` - The PEM-encoded public key of the client certificate.
- `api_gateway_client_certificate_arn` - Amazon Resource Name (ARN)
- `api_gateway_documentation_part_id` - The unique ID of the Documentation Part
- `api_gateway_documentation_version_id` - The unique ID of the Documentation version
- `api_gateway_deployment_id` - The ID of the deployment
- `api_gateway_deployment_invoke_url` - The URL to invoke the API pointing to the stage, e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod
- `api_gateway_deployment_execution_arn` - The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod
- `api_gateway_deployment_created_date` - The creation date of the deployment
- `api_gateway_stage_id` - The ID of the stage
- `api_gateway_stage_arn` - Amazon Resource Name (ARN)
- `api_gateway_stage_invoke_url` - The URL to invoke the API pointing to the stage, e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod
- `api_gateway_stage_execution_arn` - The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function, e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod
- `api_gateway_base_path_mapping_id` - The ID of the base path mapping
- `api_gateway_method_settings_id` - The ID of the method settings
- `api_gateway_usage_plan_id` - The ID of the API resource
- `api_gateway_usage_plan_name` - The name of the usage plan.
- `api_gateway_usage_plan_description` - The description of a usage plan.
- `api_gateway_usage_plan_api_stages` - The associated API stages of the usage plan.
- `api_gateway_usage_plan_quota_settings` - The quota of the usage plan.
- `api_gateway_usage_plan_throttle_settings` - The throttling limits of the usage plan.
- `api_gateway_usage_plan_product_code` - The AWS Markeplace product identifier to associate with the usage plan as a SaaS product on AWS Marketplace.
- `api_gateway_usage_plan_arn` - Amazon Resource Name (ARN)
- `api_gateway_usage_plan_key_id` - The Id of a usage plan key.
- `api_gateway_usage_plan_key_key_id` - The identifier of the API gateway key resource.
- `api_gateway_usage_plan_key_key_type` - The type of a usage plan key. Currently, the valid key type is API_KEY.
- `api_gateway_usage_plan_key_usage_plan_id` - The ID of the API resource
- `api_gateway_usage_plan_key_name` - The name of a usage plan key.
- `api_gateway_usage_plan_key_value` - The value of a usage plan key.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
