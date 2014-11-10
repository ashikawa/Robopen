module.exports = (robot) ->
  robot.router.get "/uptimerobot/:room", (req, res) ->
    {room, monitorID, monitorURL, monitorFriendlyName, alertType, alertDetails, monitorAlertContacts} = req.params;
    robot.send room, """
    Monitor is #{alertDetails}
    #{monitorFriendlyName} (#{monitorURL})
    """
    res.end "OK"