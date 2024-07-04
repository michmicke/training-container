# Getting Started

1. This app is personally greeting the user after sharing his or her name (aka
   Hello World). It generates random friendly messages until it has hit a
   threshold and gets annoyed. Different messages are popping up then.
2. It consists of three components. Please get familiar with [the structural
   diagram](structure.excalidraw.svg) before starting. The three
   components are implemented in their respective folders: `frontend`,
   `greetings` and `visits`.
   ![image shows the sturcture of the app and communication between the three
   components. The frontend calls a HTTP endpoint on the greetings API, which
   in turn calls the visits-app. The visits-app is the only component with its
   own sqlite-database.](./structure.excalidraw.svg)
3. The three folders each contain a dedicated `README.md`. Get familiar with
   each one of them.
4. **Now lets get our hands dirty!**
5. Start with containerizing the `greetings` application. Create a `Dockerfile`
   inside `./greetings` and insert the neccessary instructions to build a
   functional container image. Start the image by manually calling the `docker`
   or `podman` command. And invoke the API by using `curl`, Postman or similar
   tools.
6. Now continue with `frontend` configuring the running `greetings`-container.
   And see the `frontend` and `greetings` API in action!
7. Finally, containerize the `visits` application. This is the first time you
   have to handle data in our application. Mind the schema migrations.
8. You can turn on the counting mode and thereby connecting `visits` to the
   `greetings` application. Consider the [configuration section in the
   `greetings` folder](greetings/README.md#Configuration).
9. Now replace all the manual fiddling with `docker`/`podman` commands and
   create a `compose.yaml` inside the root folder. This will consolidate your
   container setup.
