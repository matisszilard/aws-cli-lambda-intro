
# Create a lambda function from cli
function_name="test_function"
arn="invalid"
project="hello_there"
create-function: zip
	aws lambda create-function \
	--function-name ${function_name} \
	--runtime "nodejs12.x" \
	--role ${arn} \
	--handler "${project}.handler" \
	--timeout 3 \
	--memory-size 128 \
	--zip-file "fileb://${project}.zip"

# Delete a function from CLI
function_name="test_function"
delete-function:
	aws lambda delete-function --function-name ${function_name}

# Create a new role
role_name="test-role"
create-role:
	aws iam create-role --role-name ${role_name} --assume-role-policy-document file://roles/lambda-trust-policy.json

# Delete an existing role
role_name="test-role"
delete-role:
	aws iam delete-role --role-name ${role_name}

project="hello_there"
zip: clean
	cd src/${project}; zip ../../${project}.zip ${project}.js; cd ../..

clean:
	rm -f hello_there.zip
	rm -f general_kenobi.zip
