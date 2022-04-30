window.addEventListener('message', function(event) {

	var data = event.data;
	
	switch(data.action) {
		case 'gopro':
			if (data.state) {
				$('#gopro').fadeIn()
			} else { 
				$('#gopro').fadeOut()
			}
		break;
		
		case 'radio':
			if (data.state) {
				$('#radio').fadeIn()
			} else { 
				$('#radio').fadeOut()
			}			
		break;
		
		case 'bodycam':
			if (data.state) {
				$('#bodycam').fadeIn()
			} else { 
				$('#bodycam').fadeOut()
			}				
		break;
		
		case 'gps':
			console.log(data.state)
			
			if (data.state) {
				$('#gps').fadeIn()
			} else { 
				$('#gps').fadeOut()
			}			
		break;	
	}
	

});
