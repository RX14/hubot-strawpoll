# Description:
#   Allows Hubot to create a Strawpoll
#
# Dependencies:
#   'querystring'
#
# Configuration:
#   None
#
# Commands:
#   hubot strawpoll "<option 1>" "<option 2>" "<option x>" - Creates Strawpoll multiple selection with options
#   hubot strawpoll <option1> <option2> <option3> - Creates Strawpoll multiple selection  with options
#
# Author:
#   ericsaupe

QS = require 'querystring'

module.exports = (robot) ->
    robot.respond /strawpoll "(.*)"/i, (msg) ->
        options = msg.match[1].split('" "')
        data = QS.stringify({
          title: "Strawpoll " + Math.floor(Math.random() * 10000),
          options: options,
          permissive: true
          })
        req = robot.http('http://strawpoll.me/api/v2/polls').headers({'X-Requested-With': 'XMLHttpRequest', 'Content-Type': 'application/x-www-form-urlencoded'}).post(data) (err, res, body) ->
          if err
            msg.send "Encountered an error :( #{err}"
            return
          msg.reply('http://strawpoll.me/' + JSON.parse(body)['id'])

    robot.respond /strawpoll ([^"]+)/i, (msg) ->
        options = msg.match[1].split(' ')
        data = QS.stringify({
          title: "Strawpoll " + Math.floor(Math.random() * 10000),
          options: options,
          permissive: true
          })
        req = robot.http('http://strawpoll.me/api/v2/polls').headers({'X-Requested-With': 'XMLHttpRequest', 'Content-Type': 'application/x-www-form-urlencoded'}).post(data) (err, res, body) ->
          if err
            msg.send "Encountered an error :( #{err}"
            return
          msg.reply('http://strawpoll.me/' + JSON.parse(body)['id'])

