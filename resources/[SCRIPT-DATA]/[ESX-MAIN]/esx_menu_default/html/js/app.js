(function(){

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
			'<div class="head"><span>{{{title}}}</span></div>' +
				'<div class="menu-items">' + 
					'{{#elements}}' +
						'<div class="menu-item {{#selected}}selected{{/selected}}">' +
							'{{{label}}}{{#isSlider}}: <span>&lt; {{{sliderLabel}}} &gt;</span><input type="text" style="display: none;">{{/isSlider}}' +
						'</div>' +
					'{{/elements}}' +
				'</div>'+
			'</div>' +
		'</div>'
	;

	window.ESX_MENU       = {};
	ESX_MENU.ResourceName = 'esx_menu_default';
	ESX_MENU.opened       = {};
	ESX_MENU.focus	= [];
	ESX_MENU.pos	  = {};

	ESX_MENU.open = function(namespace, name, data){

		if(typeof ESX_MENU.opened[namespace] == 'undefined')
			ESX_MENU.opened[namespace] = {};

		if(typeof ESX_MENU.opened[namespace][name] != 'undefined')
			ESX_MENU.close(namespace, name);

		if(typeof ESX_MENU.pos[namespace] == 'undefined')
			ESX_MENU.pos[namespace] = {};

		for(let i=0; i<data.elements.length; i++)
			if(typeof data.elements[i].type == 'undefined')
				data.elements[i].type = 'default';

		data._index     = ESX_MENU.focus.length;
		data._namespace = namespace;
		data._name      = name;

		for(let i=0; i<data.elements.length; i++){
			data.elements[i]._namespace = namespace;
			data.elements[i]._name      = name;
		}

		ESX_MENU.opened[namespace][name] = data;
		ESX_MENU.pos   [namespace][name] = 0;

		for(let i=0; i<data.elements.length; i++){
			if(data.elements[i].selected)
				ESX_MENU.pos[namespace][name] = i;
			else
				data.elements[i].selected = false
		}

		ESX_MENU.focus.push({
			namespace: namespace,
			name     : name
		});
		
		ESX_MENU.render();

		$('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
	}

	ESX_MENU.close = function(namespace, name){
		
		delete ESX_MENU.opened[namespace][name];

		for(let i=0; i<ESX_MENU.focus.length; i++){
			if(ESX_MENU.focus[i].namespace == namespace && ESX_MENU.focus[i].name == name){
				ESX_MENU.focus.splice(i, 1);
				break;
			}
		}

		ESX_MENU.render();

	}

	ESX_MENU.render = function(){

		let menuContainer       = document.getElementById('menus');
		let focused	     = ESX_MENU.getFocused();
		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for(let namespace in ESX_MENU.opened){
			for(let name in ESX_MENU.opened[namespace]){

				let menuData = ESX_MENU.opened[namespace][name];
				let view     = JSON.parse(JSON.stringify(menuData))

				for(let i=0; i<menuData.elements.length; i++){

					let element = view.elements[i];

					switch(element.type){

						case 'default' : break;

						case 'slider' : {
							
							element.isSlider    = true;
							element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value];

							break;
						}

						default : break;

					}

					if(i == ESX_MENU.pos[namespace][name])
						element.selected = true;
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];

				$(menu).hide();

				menuContainer.appendChild(menu);
			}
		}

		if(typeof focused != 'undefined')
			$('#menu_' + focused.namespace + '_' + focused.name).show();

		$(menuContainer).show();

	}

	ESX_MENU.submit = function(namespace, name, data){
		SendMessage(ESX_MENU.ResourceName, 'menu_submit', {
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : ESX_MENU.opened[namespace][name].elements
		});
	}

	ESX_MENU.delete = function(namespace, name, data){
		SendMessage(ESX_MENU.ResourceName, 'menu_delete', {
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : ESX_MENU.opened[namespace][name].elements
		});
	}

	ESX_MENU.cancel = function(namespace, name){
		SendMessage(ESX_MENU.ResourceName, 'menu_cancel', {
			_namespace: namespace,
			_name     : name
		});
	}

	ESX_MENU.change = function(namespace, name, data){
		/*SendMessage(ESX_MENU.ResourceName, 'menu_change', {*/
		$.post('http://' + ESX_MENU.ResourceName + '/menu_change', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : ESX_MENU.opened[namespace][name].elements
		}));
	}

	ESX_MENU.getFocused = function(){
		return ESX_MENU.focus[ESX_MENU.focus.length - 1];
	}

	window.onData = (data) => {

		switch(data.action){

			case 'openMenu' : {
				ESX_MENU.open(data.namespace, data.name, data.data);
				break;
			}

			case 'closeMenu' : {
				ESX_MENU.close(data.namespace, data.name);
				break;
			}

			case 'controlPressed' : {

				switch(data.control) {

					case 'ENTER' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							if(menu.elements.length > 0)
								ESX_MENU.submit(focused.namespace, focused.name, elem);

						}

						break;
					}

					case 'BACKSPACE' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined')
							ESX_MENU.cancel(focused.namespace, focused.name);

						break;
					}

					case 'PAGEDOWN' : {
						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							let span    = $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected span');
							if(span.is(':visible')) {
								span.css('display', 'none');

								let input = $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected input');
								input.css('display', 'inline');
								input.val(elem.value);

								input.focus();
								$(input).on('keyup', function (e) {
									if (e.which == 13) {
										$(input).off(e);

										let curr = parseInt(input.val());
										if(curr.toString() == input.val() && curr != elem.value) {
											let restrict = (typeof elem.restrict == 'undefined') ? [] : elem.restrict;
											let min = (typeof elem.min == 'undefined') ? 0 : elem.min;
											let max = null;

											if(typeof elem.options != 'undefined' && elem.value < (elem.options.length - 1))
												max = (elem.options.length - 1);

											if(typeof elem.max != 'undefined' && elem.value < elem.max)
												max = elem.max;

											if(curr < min || (max != null && curr > max) || restrict.includes(curr))
												curr = 0;

											elem.value = curr;
										}

										ESX_MENU.change(focused.namespace, focused.name, elem);
										ESX_MENU.render();
									} else if(e.which == 27) {
										$(input).off(e);
										ESX_MENU.change(focused.namespace, focused.name, elem);
										ESX_MENU.render();
									}
								});
							}

						}

						break;
					}

					case 'DELETE' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							switch(elem.type) {

								case 'item_money':
								case 'item_weapon':
								case 'item_account':
								case 'item_standard': {

									if(menu.elements.length > 0)
										ESX_MENU.delete(focused.namespace, focused.name, elem);

									break;

								}

								case 'slider' : {

									let value = (typeof elem.min == 'undefined') ? 0 : elem.min;
									if(value != elem.value) {
										elem.value = value;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									ESX_MENU.render()
									break;

								}

								default: break;

							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();

						}

						break;
					}

					case 'TOP' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];

							if(pos > 0)
								ESX_MENU.pos[focused.namespace][focused.name]--;
							else
								ESX_MENU.pos[focused.namespace][focused.name] = menu.elements.length - 1;

							let elem = menu.elements[ESX_MENU.pos[focused.namespace][focused.name]];

							for(let i = 0; i < menu.elements.length; i++) {
								if(i == ESX_MENU.pos[focused.namespace][focused.name])
									menu.elements[i].selected = true
								else
									menu.elements[i].selected = false
							}

							ESX_MENU.change(focused.namespace, focused.name, elem)
							ESX_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();

						}

						break;

					}

					case 'DOWN' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let length  = menu.elements.length;

							if(pos < length - 1)
								ESX_MENU.pos[focused.namespace][focused.name]++;
							else
								ESX_MENU.pos[focused.namespace][focused.name] = 0;

							let elem = menu.elements[ESX_MENU.pos[focused.namespace][focused.name]];

							for(let i = 0; i < menu.elements.length; i++) {
								if(i == ESX_MENU.pos[focused.namespace][focused.name])
									menu.elements[i].selected = true
								else
									menu.elements[i].selected = false
							}

							ESX_MENU.change(focused.namespace, focused.name, elem)
							ESX_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();

						}

						break;
					}

					case 'LEFT' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							switch(elem.type){

								case 'default': break;

								case 'slider' : {
								
									let min = (typeof elem.min == 'undefined') ? 0 : elem.min;
									let restrict = (typeof elem.restrict == 'undefined') ? [] : elem.restrict;
									let curr = elem.value;

									if(curr > min) {
										while(true) {
											curr--;
											if(!restrict.includes(curr))
												break;
											else if(curr == min) {
												curr = elem.value;
												break;
											}										
										}

										elem.value = curr;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									ESX_MENU.render();
									break;
								}

								default: break;

							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();

						}

						break;
					}

					case 'RIGHT' : {

						let focused = ESX_MENU.getFocused();

						if(typeof focused != 'undefined') {

							let menu    = ESX_MENU.opened[focused.namespace][focused.name];
							let pos     = ESX_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							switch(elem.type){

								case 'default': break;

								case 'slider' : {

									let restrict = (typeof elem.restrict == 'undefined') ? [] : elem.restrict;
									let curr = elem.value;
									let max = null;

									if(typeof elem.options != 'undefined' && elem.value < (elem.options.length - 1))
										max = (elem.options.length - 1);

									if(typeof elem.max != 'undefined' && elem.value < elem.max)
										max = elem.max;

									if(max != null && curr < max) {
										while(true) {
											curr++;
											if(!restrict.includes(curr))
												break;
											else if(curr == max) {
												curr = elem.value;
												break;
											}										
										}

										elem.value = curr;
										ESX_MENU.change(focused.namespace, focused.name, elem);
									}

									ESX_MENU.render();
									break;
								}

								default: break;

							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();

						}

						break;
					}

					default : break;

				}

				break;
			}

		}

	}

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data)
		});
	}

})()