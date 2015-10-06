# Shouty

Shouty is a social networking application for short physical distances.
When someone shouts, only people within 1000m can hear it.

Shouty doesn't exist yet - you will implement it yourself!

That is, if you're attending a BDD/Cucumber course.

## Agenda

### Set up environment

* `gem install bundler`
* `bundle` - this will install cucumber
* `bundle exec cucumber` - this runs cucumber!

You should see:

    1 scenario (1 passed)

#### Windows troubleshooting

If you get an error installing gems,
create a file in `C:\Users\YOURNAME\.gemrc` with:

```yaml
# Download gems with http instead of https
:sources:
- http://rubygems.org
```

You'll also need to change your `Gemfile` to use `http` if you have this problem.

### HTTP_PROXY

Your IT department should be able to tell you what the proxy URL is.

#### Windows

* Right-click My Computer, and then click Properties
* Click the Advanced tab
* Click Environment variables
  * Click New to add a new user variable
  * Name: `HTTP_PROXY`
  * Value: What the IT department told you

On OS X / Linux:

    export HTTP_PROXY=<What the IT department told you>

## Brainstorm capabilities

* Who are the main stakeholders?
* What can people do with the app?
* What are the main differentiators from other apps?

### Pick one capability

* Define rules
* Create high level examples (Friends episodes)

Then do this for each example to discover more examples:

* Can you think of a context where the outcome would be different?
* Are there any other outcomes we haven't thought about?

### Implement one capability. Text UI only.

* Write a Cucumber Scenario for one of the examples
* Make it pass!
