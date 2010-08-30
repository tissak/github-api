# Description

A simple proof of concept helper for accessing details about peoples followers and watched repos for the purpose of doing some git snooping.

# Usage

Copy the config.yml.sample to config.yml and update the username / token details.

## Users

    GitHub::User.fetch("username")

Search for users

    GitHub::User.search("username")

Grab watched repos

    user = GitHub::User.fetch("username")
    user.watching

or in one query

    GitHub::User.watching("username")


## Repos

search via

    GitHub:Repository.search("term")

## Reports

There is only one type of report currently. A hash of repo names with the number of people un a users following list that are watching that repo. IE this translates into a list of what others are seeing as important in the github community.

    GitHub::Report.most_watched

Will default to running on your follower list or

    GitHub::Report.most_watched("username")

will report on another users follower list.

Note..this will take some time to make repeat queries and there is currently no throttling to prevent you exceeding the 60 requests per minute limit. 