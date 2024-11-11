# Containerize Everything!

1. Start with containerizing the `greetings` application. Create a `Dockerfile`
   inside `./greetings` and insert the neccessary instructions to build a
   functional container image. Start the image by manually calling the `docker`
   or `podman` command. And invoke the API by using `curl`, Postman or similar
   tools.
2. Now continue with `frontend` configuring the running `greetings`-container.
   And see the `frontend` and `greetings` API in action!
3. Finally, containerize the `visits` application. This is the first time you
   have to handle data in our application. Mind the schema migrations.
4. You can turn on the counting mode and thereby connecting `visits` to the
   `greetings` application. Consider the [configuration section in the
   `greetings` folder](greetings/README.md#Configuration).
5. Now replace all the manual fiddling with `docker` commands and create a
   `compose.yaml` inside the root folder. This will consolidate your container
   setup.

Next: [Deployment](./04_deployment.md)
