  // This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require jquery.easing
//= font-awesome-rails
//= require_tree .  

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




(function($){
  $(window).on('load', function() {
      window.loaded = true;
  });
  $(function(){
    $.fn.infiniteslide = function(options){
      //option
      var settings = $.extend({
        'speed': 100, //速さ　単位はpx/秒です。
        'direction': 'left', //up/down/left/rightから選択
        'pauseonhover': true, //マウスオーバーでストップ
        'responsive': false, //子要素の幅を%で指定しているとき
        'clone': 1
      },options);
      
      var setCss = function(obj,direction){
        $(obj).wrap('<div class="infiniteslide_wrap"></div>').parent().css({
          overflow: 'hidden'
        });

        if(direction == 'up' || direction == 'down'){
          var d = 'column';
        } else {
          var d = 'row';
        }
                
        $(obj).css({
          display: 'flex',
          flexWrap: 'nowrap',
          alignItems: 'center',
          '-ms-flex-align': 'center',
          flexDirection: d
        }).children().css({
            flex: 'none',
            display: 'block'
          });
      }
      
      var setClone = function(obj,clone){
        var $clone = $(obj).children().clone().addClass('infiniteslide_clone');
        i = 1;
        while(i <= clone){
          $clone.clone().appendTo($(obj));
          i++;
        }
      }
      
      var getWidth = function(obj){
        w = 0;
        $(obj).children(':not(.infiniteslide_clone)').each(function(key,value){
          w = w + $(this).outerWidth(true);
        });
        return w;
      }
      var getHeight = function(obj){
        h = 0;
        $(obj).children(':not(.infiniteslide_clone)').each(function(key,value){
          h = h + $(this).outerHeight(true);
        });
        return h;
      }

      
      var getSpeed = function(l,s){
        return l / s;
      }
      var getNum = function(obj,direction){
        if(direction == 'up' || direction == 'down'){
          var num = getHeight(obj);
        } else {
          var num = getWidth(obj);
        }
        return num;
      }
      
      var getTranslate = function(num,direction){
        if(direction == 'up' || direction == 'down'){
          var i = '0,-' + num + 'px,0';
        } else {
          var i = '-' + num + 'px,0,0';
        }
        return i;
      }
      
      var setAnim = function(obj,id,direction,speed){
        var num = getNum(obj,direction);
        if(direction == 'up' || direction == 'down'){
          $(obj).parent('.infiniteslide_wrap').css({
            height: num + 'px'
          });
        }
        var i = getTranslate(num,direction);
        
        $(obj).attr('data-style','infiniteslide' + id);

        var css = '@keyframes infiniteslide' + id + '{' + 
                'from {transform:translate3d(0,0,0);}' + 
                'to {transform:translate3d(' + i + ');}' + 
              '}';
        $('<style />').attr('id','infiniteslide' + id + '_style')
        .html(css)
        .appendTo('head');
        
        if(direction == 'right' || direction == 'down'){
          var reverse = ' reverse';
        } else {
          var reverse = '';
        }
        
        $(obj).css({
          animation: 'infiniteslide' + id + ' ' + getSpeed(num,speed) + 's linear 0s infinite' + reverse
        });
      }
      var setStop = function(obj){
        $(obj).on('mouseenter',function(){
          $(this).css({
            animationPlayState: 'paused'
          });
        }).on('mouseleave',function(){
          $(this).css({
            animationPlayState: 'running'
          });
        });
      }
      
      var setResponsive = function(obj,direction){
          var num = getNum(obj,direction);
          var i = getTranslate(num,direction);
          return i;
        };
      
      
      
    
      return this.each(function(key,value){
        var $this = $(this);
        var num = Date.now() + Math.floor(10000*Math.random()).toString(16);
        if(settings.pauseonhover == true){
          setStop($this);
        }
        var _onload = function(){
          setCss($this,settings.direction);
          setClone($this,settings.clone);
          setAnim($this,num,settings.direction,settings.speed);
          
          if(settings.responsive){
            $(window).on('resize',function(){
              var i = setResponsive($this,settings.direction);
              var styleid = $this.attr('data-style');
              var stylehtml = $('#' + styleid + '_style').html();
              
              var stylehtml_new = stylehtml.replace(/to {transform:translate3d\((.*?)\)/,'to {transform:translate3d(' + i + ')');
              $('#' + styleid + '_style').html(stylehtml_new);

            });
          }
        };

        if (window.loaded) {
          _onload();
        } else {
          $(window).on('load', _onload);
        }
      });
      
    }
  });
})(jQuery);

