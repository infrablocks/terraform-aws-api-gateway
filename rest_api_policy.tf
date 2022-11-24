data "aws_iam_policy_document" "api_policy" {
  source_policy_documents = [
    replace(
      var.api_gateway_rest_api_source_policy_document,
      "$${api_gateway_rest_api_execution_arn}",
      aws_api_gateway_rest_api.api.execution_arn
    )
  ]
}

resource "aws_api_gateway_rest_api_policy" "api_policy" {
  for_each = var.include_api_gateway_rest_api_policy ? toset(["default"]) : toset([])

  rest_api_id = aws_api_gateway_rest_api.api.id
  policy = data.aws_iam_policy_document.api_policy.json
}
