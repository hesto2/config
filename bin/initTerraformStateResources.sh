echo "Customer name: (this will be used as the bucket prefix)"
read bucketName
aws s3 mb s3://$bucketName-terraform-state --region us-west-2
aws dynamodb create-table --table-name terraform-lock --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --key-schema AttributeName=LockID,KeyType=HASH --attribute-definitions AttributeName=LockID,AttributeType=S