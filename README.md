# On The Beach Academy

## Dependencies

* git ([windows](http://msysgit.github.com/), [mac os x: using brew](http://brew.sh/), linux: probably apt-get or yum git-core)
* You will need a modern version of ruby (2.0 or greater)

## Setup

Clone this repository:

```bash
$ git clone https://github.com/tooky/otb-academy-oct-2015.git
```

Change directories so that you're in the project:

```bash
$ cd otb-academy-oct-2015
```

## Exercises

The classes will consist of various exercises. Each exercise will be in
a subfolder of this directory, and should contain a README with more
information.

During the class we will from time to time update the `master` branch with new
exercises or progress. So while we work on an exercise, you should make periodic
commits saving your work, but DO NOT commit any changes to the `master` branch,
instead work in your own local branches.

So if we are working on the `bottles` you would 

```bash
$ git checkout master
```

Create a new branch to keep your work on the exercise

```bash
$ git checkout -b my-bottles-working
```

Change to the `bottles` directory and work on the problem

```bash
$ cd bottles
```

When you want to save your work, stage and commit changes:

```bash
$ git add . # the dot is important
$ git commit -m "Explain your change"
```

When we start working on a new exercise - or are moving forwards with this
problem, save your work as about, and then switch back to master.

```bash
$ git checkout master
```

Pull the latest version from GitHub:

```bash
$ git pull origin
```

Then create another new branch to work on the next thing:

```bash
$ git checkout -b my-bottles-working-2
```

## Git: Troubleshooting / Recovery

### Throw it all away

If you have gone down a blind alley, and you just want to start over, git makes
it easy to clean up and start again.

First of all make sure git knows about all of your files:

```bash
$ git add .
```

Then throw away the changes:

```bash
$ git reset --hard HEAD
```

You will find you are back at clean directory, where you last committed.

### Did you commit to master by mistake?

Make a branch to keep all your changes:

```bash
git branch my-working-branch
```

Make sure you've got the latest version from GitHub

```bash
git fetch origin
```

Then tell git to create a new copy of master, throwing away the old one:

```bash
$ git reset --hard origin/master
```
