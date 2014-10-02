
$(document).ready(function(){
	$('#loggedin-screen').hide();
 	$('#login-button').click(function(e){
        e.preventDefault();
        var user = $('#main-form input[name=name]').val();
        var password = $('#main-form input[name=password]').val();
		console.log(user);
		console.log(password);
        $.ajax({
	        type: 'post',
	        url: 'http://afternoon-coast-1369.herokuapp.com/users/login',
	        data: JSON.stringify({user: user, password: password}),
	        contentType:'application/json', 
	        dataType: 'json',
	        success: function(data) {
		        console.log(data);
		        if(data.errCode < 0){
			        $('#main-screen .message').html(data['errCode']);
		        }
				else{
					$('#main-screen').hide();
					$('#loggedin-screen').show();
					$('#loggedin-screen .username').html(user);
					$('#loggedin-screen .count').html(data['count']);
				}
		        
		    }
	
        });
    });
 	$('#addUser-button').click(function(e){
        e.preventDefault();
        var user = $('#main-form input[name=name]').val();
        var password = $('#main-form input[name=password]').val();
        console.log(user);
		console.log(password);
        $.ajax({
	        type: 'post',
	        url: 'http://afternoon-coast-1369.herokuapp.com/users/add',
	        data: JSON.stringify({user: user, password: password}),
	        contentType:'application/json', 
	        dataType: 'json',
	        success: function(data) {
		        console.log(data);
		        if (data.errCode < 0){
		        $('#main-screen .message').html(data['errCode']);
	            }
	            else{
					$('#main-screen').hide();
					$('#loggedin-screen').show();
					$('#loggedin-screen .username').html(user);
					$('#loggedin-screen .count').html(data['count']);
				}
	        }
	
        });
		
    });
    $('#logout-button').click(function(e){
	    $('#main-screen').show();
	    $('#loggedin-screen').hide();
    })
});