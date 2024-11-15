# Deployment on x86

## Setup

Make sure you have installed both virtualbox and
VagrantBox.

## Provisioning

1. `vagrant up`
2. `ssh-copy-id ubuntu@192.168.56.43` You have to enter the password once. It
   is "ubuntu". Then do the same for the second node
   `ssh-copy-id ubuntu@192.168.56.42`
3. set up pulling images from `node-1`
   1. visit http://192.168.56.43 and login using username "admin" and password
      "Harbor12345".
   2. create a project "container-training", and open up the created project.
   3. create a robot account with "Pull" permission for "Repository"
   4. `ssh ubuntu@192.168.56.42` and `docker login 192.168.56.42` using the
      credentials presented after the last step.
4. setup a remote docker context
   1. create or update `/etc/docker/daemon.json` on your devmachine and write
      `{"insecure-registries":["<registry ip>"]}` (meaning if there already was
      a config just update or add the `insecure-registries` field.
   2. `docker context create training-container --docker "host=ssh://ubuntu@<registry ip>"`
4. setup a remote docker context by running
   `docker context create container-training --docker "host=ssh://vagrant@192.168.56.42"`
   from a local terminal

## Actual Deployment

1. Override relevant (build) configuration possibly by creating a dedicated
   compose file as an overwrite. Note that your app will be reached by your
   private IP `192.168.56.42`.
2. `docker compose build` (add your overwrites like `-f compose.production.yaml`.
3. `docker push 192.168.56.43/container-training/frontend:0.1.0`,
   `docker push 192.168.56.43/container-training/greetings:0.1.0`,
   `docker push 192.168.56.43/container-training/visits:0.1.0`
2. `docker compose build` (add your overwrites like `-f compose.production.yaml`.
4. `docker --context=container-training compose up -d` (again use `-f` for the overwrite)
5. run the database migrations for `visits` via
   `docker --context=container-training compose run --rm -it prisma migrate deploy`.

Your app should be reachable at `192.168.56.42`.

[Back to Home](../README.md)
