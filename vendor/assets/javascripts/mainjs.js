//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require mainjs
//= require sliderjs
//= require jquery
//= require bootstrap
//= require turbolinks
//= require jquery.easing
//= font-awesome-rails
//= require_tree .  


//Scrolls main nav bar up and down
$(window).on('scroll', function() {
      if($(window).scrollTop()){
        $('nav').addClass('black');  
      }
      else{
        $('nav').removeClass('black');
      }
  });

//Display password if user clicks button
function showMyPassword(choice) {
  var x = document.getElementById(choice);
  if (x.type === "password") {
    x.type = "text";
  }else{
    x.type = "password";
  }
}


function showAptNumberBox(choice){
  var selectedValue = document.getElementById(choice).value;
  if(selectedValue.toLowerCase() === 'none')
    user_addresses_attributes_0_number.style.display = 'none';
  else
    user_addresses_attributes_0_number.style.display = 'block';
  
}
