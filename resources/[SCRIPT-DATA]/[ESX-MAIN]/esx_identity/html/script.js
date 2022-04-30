$(function () {



    $(function () {
        $('.character-box').each(function () {
            var $this = $(this);
            $this.on("click", function () {
                var e = ($(this).data('charid'));
                console.log(e)
            });
        });
    });

    $('.character-box').hover(
        function () {
            $(this).css({
                "box-shadow": "0px 0px 10px 0px rgb(172, 172, 172, .9)",
                "transition": "200ms"
            });

        }, function () {
            $(this).css({
                "box-shadow": "0px 0px 10px 0px rgb(31, 31, 31, .9)",
                "transition": "200ms"
            });
        }
    );

    $(".character-box").click(function () {
        $(".character-box").removeClass('active-char');
        $(this).addClass('active-char');
        $(".character-buttons").css({ "display": "block" });
        if ($(this).attr("data-ischar") === "true") {
            $("#delete").css({ "display": "block" });
        } else {
            $("#delete").css({ "display": "none" });
        }
    });

    $("#play_button").click(function() {
        $.post("http://esx_identity/CharacterChosen", JSON.stringify({
            charid: $('.active-char').attr("data-charid")
        }));
        identity.CloseUI();
    });


    $("#delete_button").click(function () {
        $.post("http://esx_identity/DeleteCharacter", JSON.stringify({
            charid: $('.active-char').attr("data-charid")
        }));
        identity.CloseUI();
    });
    (() => {
        identity = {};

        identity.ShowUI = function (data) {
            $('.main-container').css({ "display": "block" });
            if (data.characters !== null) {
                $.each(data.characters, function (index, char) {
                    if (char.charid !== 0) {
                        var charid = char.identifier.charAt(4);
                        $('[data-charid=' + charid + ']').html('<h3 class="character-fullname">' + char.firstname + ' ' + char.lastname + '</h3><div class="character-info"></div>').attr("data-ischar", "true");
                    }
                });
            }
        };
        identity.CloseUI = function () {
            $.post('http://esx_identity/escape', JSON.stringify({}));
        };
        $("#register").submit(function (event) {
            event.preventDefault(); // Prevent form from submitting

            // Verify date
            var date = $("#dateofbirth").val();
            var dateCheck = new Date($("#dateofbirth").val());

            if (dateCheck == "Invalid Date") {
                date == "invalid";
            }

            $.post('http://esx_identity/register', JSON.stringify({
                firstname: $("#firstname").val(),
                lastname: $("#lastname").val(),
                dateofbirth: date,
                sex: $("input[type='radio'][name='sex']:checked").val(),
                height: $("#height").val()
            }));
        });

        $('#to_characters').click(function () {
            $("#register_screen").css({ "display": "none" });;
            $("#character_screen").css({ "display": "grid" });
        });

        $('#back_button').click(function () {
            $("#character_screen").css({ "display": "none" });;
            $("#register_screen").css({ "display": "grid" });
        });


        window.addEventListener('message', function (event) {
            if (event.data.type === "enableui") {
				$("#character_screen").css({ "display": "none" });
				$("#register_screen").css({ "display": "grid" });
				document.body.style.display = "block";
            } else if(event.data.type === 'enablechar') {
				console.log('ui')
				$("#register_screen").css({ "display": "none" });
				$("#character_screen").css({ "display": "grid" });	
				document.body.style.display = "block";				
			} else if(event.data.type === 'disableui') {
				$("#register_screen").css({ "display": "none" });
				$("#character_screen").css({ "display": "none" });
				document.body.style.display = "none";
			}

            let firstname1 	= event.data.firstname1;
            let lastname1 	= event.data.lastname1;
			let sex1;
			let date1		= event.data.date1;
            let firstname2  = event.data.firstname2;
            let lastname2   = event.data.lastname2;
			let sex2;
			let date2		= event.data.date2;
            let firstname3  = event.data.firstname3;
            let lastname3 	= event.data.lastname3;
			let sex3;
			let date3		= event.data.date3;
			
			if (event.data.sex1 === 'm') {
				sex1 = 'Mężczyna';
			} else if (event.data.sex === 'f') {
				sex1 = 'Kobieta';
			}
			
			if (event.data.sex2 === 'm') {
				sex2 = 'Mężczyna';
			} else if (event.data.sex2 === 'f') {
				sex2 = 'Kobieta';
			}
			
			if (event.data.sex3 === 'm') {
				sex3 = 'Mężczyna';
			} else if (event.data.sex3 === 'f') {
				sex3 = 'Kobieta';
			}

            $("#firstname1").text(firstname1);
            $("#lastname1").text(lastname1);
			$("#sex1").text(sex1);
			$('#date1').text(date1);
            $("#firstname2").text(firstname2);
            $("#lastname2").text(lastname2);
			$("#sex2").text(sex2);
			$('#date2').text(date2);
            $("#firstname3").text(firstname3);
            $("#lastname3").text(lastname3);
			$("#sex3").text(sex3);
			$('#date3').text(date3);

           //To leave the UI using ESCAPE
            document.onkeyup = function (data) {
                if (data.which == 27) { // Escape key
                    $.post('http://esx_identity/escape', JSON.stringify({}));
                }
            };
        });
    })();
}); 