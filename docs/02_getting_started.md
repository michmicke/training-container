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

Next: [Containerize Everything!](./03_containerize_everything.md)
