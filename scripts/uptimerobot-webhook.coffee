module.exports = (robot) ->
  robot.router.get "/uptimerobot/:room", (req, res) ->
    {room, monitorID, monitorURL, monitorFriendlyName, alertType, alertDetails, monitorAlertContacts} = req.params;
    robot.send {room: room}, """
    Monitor is #{alertDetails}
    #{monitorFriendlyName} (#{monitorURL})
    """
    res.end "OK"

# http://mighty-bayou-2930.herokuapp.com/uptimerobot/8712?monitorID=11&monitorURL=example.com&monitorFriendlyName=Example&alertType=0&alertDetails=FAIL&monitorAlertContacts=Contacts