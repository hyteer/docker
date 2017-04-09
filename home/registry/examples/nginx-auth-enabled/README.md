## Example configuration of docker registry, docker-registry-web and nginx

### How to run:

1. Download and extract example files
        
        curl -Ls https://github.com/mkuchin/docker-registry-web/releases/download/v0.1.2/examples.tar.gz | tar -xzv
        cd examples/nginx-auth-enabled/
        
2. Generate private key and self signed certificate with script:
    
        ./generate-keys.sh
    
3. Start containers with docker-compose    
    
        docker-compose up
     
It will run docker registry on `localhost` and web ui on `http://localhost/`.
To enable access to the registry from other hosts please change docker registry config property `auth.token.realm` to externally accessible URL of `registry-web`.

### How to check if it working:
  
1. Login into `http://localhost/` with *admin/admin* username/password
2. Create test user and grant 'write-all' role to that user.
3. On the local shell:
         
         docker login localhost
         docker pull hello-world
         docker tag hello-world localhost/hello-world:latest
         docker push localhost/hello-world:latest
         docker rmi localhost/hello-world:latest
		 docker run localhost/hello-world:latest