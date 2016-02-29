$(document).on('ready page:load', ready);
function ready() {




  var apiKey = 45508312; // Replace with your API key. See https://dashboard.tokbox.com/projects
  var sessionId = $('#foo-name').val(); // Replace with your own session ID. See https://dashboard.tokbox.com/projects
  var token = $('#token').val();  // Replace with a generated token. See https://dashboard.tokbox.com/projects

  var session;
  var publisher;
  var subscribers = {};
  var VIDEO_WIDTH = 320;
  var VIDEO_HEIGHT = 240;

  OT.on("exception", exceptionHandler);

  // Un-comment the following to set automatic logging:
  //  OT.setLogLevel(OT.DEBUG);

  if (!(OT.checkSystemRequirements())) {
    alert("You don't have the minimum requirements to run this application.");
  } else {
    session = OT.initSession(sessionId);	// Initialize session

    // Add event listeners to the session

    session.on('sessionConnected', sessionConnectedHandler);
    session.on('sessionDisconnected', sessionDisconnectedHandler);
    session.on('connectionCreated', connectionCreatedHandler);
    session.on('connectionDestroyed', connectionDestroyedHandler);
    session.on('streamCreated', streamCreatedHandler);
    session.on('streamDestroyed', streamDestroyedHandler);

  }

  function connect() {
    session.connect(apiKey, token);
  }

  function disconnect() {
    session.disconnect();
    hide('disconnectLink');
    hide('publishLink');
    hide('unpublishLink');
  }

  // Called when user wants to start publishing to the session
  function startPublishing() {
    if (!publisher) {
      var parentDiv = document.getElementById("myCamera");
      var publisherDiv = document.createElement('div'); // Create a div for the publisher to replace
      publisherDiv.setAttribute('id', 'opentok_publisher');
      parentDiv.appendChild(publisherDiv);
      var publisherProps = {width: VIDEO_WIDTH, height: VIDEO_HEIGHT};
      publisher = OT.initPublisher(apiKey, publisherDiv.id, publisherProps);  // Pass the replacement div id and properties
      session.publish(publisher);
      show('unpublishLink');
      hide('publishLink');
    }
  }

  function stopPublishing() {
    if (publisher) {
      session.unpublish(publisher);
    }
    publisher = null;

    show('publishLink');
    hide('unpublishLink');
  }

  //--------------------------------------
  //  OPENTOK EVENT HANDLERS
  //--------------------------------------

  function sessionConnectedHandler(event) {
    // Subscribe to all streams currently in the Session
    //for (var i = 0; i < event.streams.length; i++) {
    //	addStream(event.streams[i]);
    //}
    show('disconnectLink');
    show('publishLink');
    hide('connectLink');
  }

  function streamCreatedHandler(event) {
    // Subscribe to the newly created streams
    //for (var i = 0; i < event.streams.length; i++) {
    addStream(event.stream);
    //}
  }

  function streamDestroyedHandler(event) {
    // This signals that a stream was destroyed. Any Subscribers will automatically be removed.
    // This default behaviour can be prevented using event.preventDefault()
  }

  function sessionDisconnectedHandler(event) {
    // This signals that the user was disconnected from the Session. Any subscribers and publishers
    // will automatically be removed. This default behaviour can be prevented using event.preventDefault()
    publisher = null;

    show('connectLink');
    hide('disconnectLink');
    hide('publishLink');
    hide('unpublishLink');
  }

  function connectionDestroyedHandler(event) {
    // This signals that connections were destroyed
  }

  function connectionCreatedHandler(event) {
    // This signals new connections have been created.
  }

  /*
  If you un-comment the call to OT.setLogLevel(), above, OpenTok automatically displays exception event messages.
  */
  function exceptionHandler(event) {
    alert("Exception: " + event.code + "::" + event.message);
  }

  //--------------------------------------
  //  HELPER METHODS
  //--------------------------------------

  function addStream(stream) {
    // Check if this is the stream that I am publishing, and if so do not publish.
    if (stream.connection.connectionId == session.connection.connectionId) {
      return;
    }
    var subscriberDiv = document.createElement('div'); // Create a div for the subscriber to replace
    subscriberDiv.setAttribute('id', stream.streamId); // Give the replacement div the id of the stream as its id.
    document.getElementById("subscribers").appendChild(subscriberDiv);
    var subscriberProps = {width: VIDEO_WIDTH, height: VIDEO_HEIGHT};
    subscribers[stream.streamId] = session.subscribe(stream, subscriberDiv.id, subscriberProps);
  }

  function show(id) {
    document.getElementById(id).style.display = 'block';
  }

  function hide(id) {
    document.getElementById(id).style.display = 'none';
  }

  $('#connectLink').click(function() {
    connect();
    // console.log('dropdown click!');
  });

  $('#publishLink').click(function() {
    startPublishing();
  });

  $('#unpublishLink').click(function() {
    stopPublishing();
  });

  $('#disconnectLink').click(function() {
    disconnect();
  });
  show('connectLink');
}
