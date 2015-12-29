# Description:
#   Allows Hubot to create a Strawpoll
#
# Dependencies:
#   'shell-quote'
#
# Configuration:
#   None
#
# Commands:
#   hubot strawpoll "title message" option1 "option 2" "<option x>" - Creates Strawpoll multiple selection with options
#
# Author:
#   RX14

parse = require('shell-quote').parse

module.exports = (robot) ->
    robot.respond /strawpoll (.*)/i, (msg) ->
        options = parse msg.match[1]
        title = options.shift()

        data = JSON.stringify
            title: title
            options: options

        req = robot.http('http://strawpoll.me/api/v2/polls')
                   .headers({'Content-Type': 'application/json'})
                   .post(data) (err, res, body) ->
            if err
                msg.send "Encountered an error :( #{err}"
                return

            json = JSON.parse(body)
            if json.error
                msg.send "Encountered an error: #{json.error} (#{json.code})"
                return

            msg.reply("http://strawpoll.me/#{json.id}")

