# Deployment on Apple Silicon

## Setup

Make sure to have [multipass](https://multipass.run/) installed. Or install it
via `brew install --cask multipass`.

## Provisioning

1. Provision the vm for the image registry.
   1. `multipass launch docker --name registry --cloud-init ./cloud-init/user-data`
   2. `multipass info registry` and take note of the IP of your local vm.
   3. `ssh-copy-id ubuntu@<registry ip>` using the IP from above. You have to
      enter the password once. It is "ubuntu".
   4. `ssh ubuntu@<registry ip>`, then
      `git clone https://github.com/michmicke/training-container`.
   5. `sudo training-container/install_harbor.sh <registry ip>`
2. Provision the deployment target.
   1. `multipass launch docker --name node-1 --cloud-init ./cloud-init/user-data`
   2. `multipass info registry` and take note of the IP of your local vm.
   3. `ssh-copy-id ubuntu@<node ip>` using the IP from above. Use the same
      password as you did with the registry.
   4. create or update `/etc/docker/daemon.json` and write
      `{"insecure-registries":["<registry ip>"]}` (meaning if there already was
      a config just update or add the `insecure-registries` field. Then do a
      `systemctl restart docker`
3. set up pulling images from `node-1`
   1. visit `http://<registry ip>`
   2. create a project "container-training"
   3. create a robot account with "Pull" permission for "Repository"
   4. `ssh ubuntu@<node ip>` and `docker login <node ip>` using the credentials
      presented after the last step.
4. setup a remote docker context
   1. Open up the Docker Desktop Dashboard. Go to the Settings. Then hit
      "Docker Engine" and add the registry's IP to `"insecure-registries"`.
   2. `docker context create training-container --docker "host=ssh://ubuntu@<registry ip>"`

## Actual Deployment

1. Override relevant (build) configuration possibly by creating a dedicated
   compose file as an overwrite. Note that your app will be reached by
   `node-1`'s IP Address.
2. `docker compose build` (add your overwrites like `-f compose.production.yaml`.
3. `docker push <registry ip>/container-training/frontend:0.1.0`,
   `docker push <registry ip>/container-training/greetings:0.1.0`,
   `docker push <registry ip>/container-training/visits:0.1.0`
4. `docker --context=container-training compose up -d` (again use `-f` for the overwrite)
5. run the database migrations for `visits` via
   `docker --context=container-training compose run --rm -it prisma migrate deploy`.

Your app should be reachable using `node-1`'s IP.

[Back to Home](../README.md)
