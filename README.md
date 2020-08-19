# Introduction to AWS lambda function using AWS cli

This is a playground project for learning how to use the AWS cli to create
lambda functions, give them proper permissions and test them using the cli.

It is heavily inspired by the [Using AWS Lambda with the AWS Command Line Interface](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-awscli.html) documentation.

## Setup AWS cli

Download the AWS cli from the original website: https://aws.amazon.com/cli/ .

```sh
aws configure
```

Set the following parameters accordingly: `AWS Access key ID`, `AWS Secret access key`,
`Default region name`, `Default output format`.

## Create an execution role for the lambda function

Roles can be created under the IAM (Identity and Access Management). The available
roles can be viewed on the web UI under the WebConsole->IAM->Roles.

The roles can listed with the CLI as well:

```sh
aws iam list-roles
```

We can create a role using the aws cli:

```sh
aws iam create-role --role-name my-specific-role --assume-role-policy-document file://roles/lambda-trust-policy.json
```

The `lambda-trust-policy.json` is an example policy json. It allows the lambda function to use the role's permission.

To add permissions to the role, use the attach-policy-to-role command. Start by adding the AWSLambdaBasicExecutionRole managed policy.

```sh
aws iam attach-role-policy --role-name my-specific-role --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

One can get information about a specific role:

```sh
aws iam get-role --role-name my-specific-role
```

For more information please run:

```sh
aws iam help
```

## Create lambda function

```sh
make create-lambda arn=arn:aws:iam::12345678901234:role/mszg-demo-lamda-role lambda_name=mszg-demo-lamda
```

## Test lambda function

We can test out our newly created lambda function using the aws cli:

```
aws lambda invoke --function-name mszg-demo-lamda out --log-type Tail
```

In the response we get base64 encode log messages up to 4 kb.

```sh
#!/bin/bash
aws lambda invoke --function-name my-function --payload '{"key": "value"}' out
sed -i'' -e 's/"//g' out
sleep 15
aws logs get-log-events --log-group-name /aws/lambda/my-function --log-stream-name $(cat out) --limit 5
```

## Useful links

- https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-awscli.html
- https://www.tutorialspoint.com/aws_lambda/aws_lambda_creating_and_deploying_using_aws_cli.htm
