resource "aws_cognito_user_pool" "rockolify" {
  name                     = "rockolify"
  auto_verified_attributes = ["email"]
  mfa_configuration        = "OFF"


  admin_create_user_config {
    allow_admin_create_user_only = false
  }
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
  password_policy {
    minimum_length                   = 6
    require_numbers                  = false
    require_symbols                  = false
    require_lowercase                = false
    require_uppercase                = false
    temporary_password_validity_days = 0
  }
  schema {
    attribute_data_type = "String"
    mutable             = true
    name                = "nickname"
    required            = false
    string_attribute_constraints {
      min_length = 1
      max_length = 100
    }
  }
  username_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                         = "client"
  user_pool_id                 = aws_cognito_user_pool.rockolify.id
  callback_urls                = ["https://rockolify.holasoyfranco.com"]
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_scopes         = ["email", "openid"]
  allowed_oauth_flows          = ["code", "implicit"]
  allowed_oauth_flows_user_pool_client = true
  generate_secret = true
}

resource "aws_cognito_user_pool_domain" "rockolify" {
  domain       = "rockolify"
  user_pool_id = aws_cognito_user_pool.rockolify.id
}

resource "aws_cognito_identity_pool" "cognito_identity_pool" {
  allow_classic_flow               = false
  allow_unauthenticated_identities = false
  identity_pool_name               = "rockolifyCognito"
  openid_connect_provider_arns     = []
  saml_provider_arns               = []
  supported_login_providers        = {}
  tags                             = {}
  tags_all                         = {}
}
