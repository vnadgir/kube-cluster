#Kube Cluster

The repostitory provides a mechanism of provisioning a kubernetes cluster using coreos, fleet and flannel. 

More detailed information can be found on the Kelsey Hightower's [tutorial](https://github.com/kelseyhightower/kubernetes-fleet-tutorial)

The user data files define the types of nodes that can be provisioned. User management is provided through the use of ssh-keys which are dropped on to the nodes at provision time. Public ssh-keys can be added to the related repository located [here](https://github.com/vnadgir-ef/public-keys) 

## Provisioning a cluster
	docker build -t="vnadgir/kube-cluster-provisioner" .

	docker run --rm vnadgir/kube-cluster-provisioner
	
	
## Testing if the provision worked
	ssh <public_ip_of_kube_master>
	
	fleetctl list-machines


If you have Fleet installed locally, use this instead 

	export FLEET_TUNNEL=<public_ip_of_kube_master>
	fleetctl --tunnel=$FLEET_TUNNEL list-machines
	
### Testing if Kubernetes is setup correctly

	ssh <public_ip_of_kube_master>
	kubecfg list /minions
