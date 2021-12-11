scp -r -i /Users/DanielJiang/Documents/ec2/LightsailDefaultKey-us-east-1.pem ./dist ubuntu@100.24.201.150:/home/ubuntu/project/sc-vue 
# scp -r -i /Users/DanielJiang/Documents/ec2/aws-jy-nx-ubuntu.pem dist ubuntu@161.189.200.186:/home/ubuntu/projects/hotel-web/hotel-back/
# aws s3 cp ./dist s3://hoteldemo.i568.me --acl public-read --recursive --profile jy-dan