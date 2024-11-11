# Deployment

## Setup

Make sure you have installed both virtualbox and
VagrantBox.

## Provisioning

1. `vagrant up`
2. copy your public ssh key to the virtual machine. You can
   do this e.g. by:
   1. Generate a ssh-config by `vagrant ssh-config > ssh-config`
   2. Copy your public key to the vagrant machine:
      `ssh-copy-id -F ssh-config -i ~/.ssh/...`
3. setup a remote docker context by
   `docker context create container-training --docker "host=ssh://vagrant@192.168.56.42"`

## Deployment

1. Override relevant (build) configuration by creating a
   `compose.production.yaml` file. Note that your app will be reached by your
   private IP `192.168.56.42`.
2. `docker --context=container-training compose -f compose.yaml -f compose.production.yaml build`
3. `docker --context=container-training compose -f compose.yaml -f compose.production.yaml up -d`
4. run the database migrations for `visits`

Your app should be reachable at `192.168.56.42`
