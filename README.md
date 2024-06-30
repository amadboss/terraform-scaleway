# The scope
This terraform code allow you to deploy the following ressources on scaleway :
- kubernetes cluster kapsule
- pool
- node
- instance
- database
- database user
- database permission
- vpc
- pvn

## Deploy you ressource
Modify the ```terraform.tfvars``` file with your need then use the following commandes to deploy:
```
$ terraform init
$ terraform apply
```

## Import existing ressource 
```
terrafom state list
```
Then use the returned template as exemple to import your ressources for instance with "poll" ressource :
```
module.k8s-pool-creation["<you pool name>"].scaleway_k8s_pool.this-pool
```
