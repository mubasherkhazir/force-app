({
	down : function(component, event, helper) {
        navigator.mediaDevices.getUserMedia({ audio: true })
        .then(stream => {
            const mediaRecorder = new MediaRecorder(stream);
    mediaRecorder.start();
  });
		console.log('keyDown');
	},
    up : function(component, event, helper) {
		console.log('keyUp');
	}
})