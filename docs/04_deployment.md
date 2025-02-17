# Deployment

## Build and Publish

1. Login to the image registry via a web browser. I will issue a personal user for you and send the password to you. If you get stuck just ask and I will help.
1. Login via `docker login <registry>`. If you do not know where the registry is deployed, just ask me and I will help.
1. Create a project inside the registry using the Web UI.
1. Update the image names in your `compose.yaml`, such that the images are residing under `<registry>/<project-name>/<repository-name>:<tag>`
1. Build the images by running `docker compose build`.
1. Push the images to registry one by one. e.g. `docker push <registry>/<project>/frontend:v1.0.0`.

## Provisioning

1. `multipass launch docker --name node --cloud-init ./cloud-init/user-data`
1. `multipass info node` and take note of the IP of your local vm. Set the hostname `training-container.localhost` to point to that ip via your local `/etc/hosts`.
1. `ssh-copy-id ubuntu@training-container.localhost` using the IP from above. You have to enter the password once. It is "ubuntu".

## Actual Deployment

1. setup a remote docker context: `docker context create training-container --docker "host=ssh://ubuntu@container-training.localhost"`
1. `docker --context=container-training compose up -d --no-build`
1. run the database migrations for `visits` via `docker --context=container-training compose run --rm -it prisma migrate deploy`.
