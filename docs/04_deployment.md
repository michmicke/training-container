# Deployment

## Setup

Make sure you have installed both virtualbox and
VagrantBox.

## Provisioning

1. `vagrant up`
2. copy your public ssh key to the virtual machine. You can
   do this e.g. by:
   1. Generate a ssh-config by `vagrant ssh-config node-1 > ssh-config`
   2. Copy your public key to the vagrant machine:
      ```
      scp -F ssh-config ~/.ssh/<name>.pub vagrant@node-1:/tmp/key.pub
      vagrant ssh node-1
      cat /tmp/key.pub >> ~/.ssh/authorized_keys
      ```
3. set up pulling images from `node-1`
   1. visit http://192.168.56.43
   2. create a project "container-training"
   3. create a robot account with "Pull" permission for "Repository"
   4. `vagrant ssh node-1` and `docker login` using the credentials presented
      after the last step.
4. setup a remote docker context by running
   `docker context create container-training --docker "host=ssh://vagrant@192.168.56.42"`
   from a local terminal

## Actual Deployment

1. Override relevant (build) configuration by creating a
   `compose.production.yaml` file. Note that your app will be reached by your
   private IP `192.168.56.42`.
2. `docker compose -f compose.yaml -f compose.production.yaml build`
3. `docker push 192.168.56.43:80/container-training/frontend:0.1.0`,
   `docker push 192.168.56.43:80/container-training/greetings:0.1.0`,
   `docker push 192.168.56.43:80/container-training/visits:0.1.0`
4. `docker --context=container-training compose -f compose.yaml -f compose.production.yaml up -d`
5. run the database migrations for `visits` via
   `docker --context=container-training compose exec prisma migrate deploy`.

Your app should be reachable at `192.168.56.42`.
