$(function(){
	window.addEventListener('message', function(event) {
		if (event.data.action == "updateStatus"){
			updateStatus(event.data.status);
		}else if (event.data.action == "updateHealth"){
			$("#health span").stop().animate({
				height: event.data.healthPrecent + '%'
			  }, {
				duration: parseInt(300),
				easing: 'linear'
			});
		}else if (event.data.action == "setTalking"){
			setTalking(event.data.value)
		}else if (event.data.action == "setProximity"){
			setProximity(event.data.value)
		}else if (event.data.action == "setID"){
			$('#idText').html(event.data.id_label);
		}else if (event.data.action == "carHud" && event.data.status == true){
			$('.hud').addClass('carHud');
		}else if (event.data.action == "carHud" && event.data.status == false){
			$('.hud').removeClass('carHud');
		}
	});
});

function updateStatus(status){
	var hunger = {}
	var thirst = {}
	status.forEach((v,i) => {
		switch(v.name) {
			case 'hunger': {
				hunger = status[i]
				break
			}
			case 'thirst': {
				thirst = status[i]
				break
			}
			default: {
				break
			}
		}
	})
	$('li#hunger span').animate({
		height: hunger.percent+'%'
	  }, {
		duration: parseInt(300),
		easing: 'linear'
	});
	$('li#water span').animate({
		height: thirst.percent+'%'
	  }, {
		duration: parseInt(300),
		easing: 'linear'
	});
}

function setProximity(value){
	var color;
	var speaker;
	if (value == "Whisper"){
		speaker = 25;
	}else if (value == "Normal"){
		speaker = 60;
	}else if (value == "Shouting"){
		speaker = 100;

	}
	$('li#voice span').animate({
		height: speaker+'%'
	  }, {
		duration: parseInt(300),
		easing: 'linear'
	});
}	

function setTalking(value){
	if (value){
		$('li#voice i').animate({
			'box-shadow': '0 0 0 2px rgba(247, 0, 255, 0.4)'
		  }, {
			duration: parseInt(300),
			easing: 'linear'
		});
	}else{
		$('#voice i').animate({
			'box-shadow': 'none'
		  }, {
			duration: parseInt(300),
			easing: 'linear'
		});
	}
}